# Lessons Architecture — Draksy

> Reference document for the lessons feature implementation.
> Covers the full data flow, Edge Function design, caching strategy, and node content contract.

---

## 1. Overview

Draksy lessons are powered by **OpenRouter**, but the AI calls are a **development-time tool only**.  
By the time the app is released, all lesson content is already stored in **Supabase PostgreSQL**.  
Users never trigger an OpenRouter call — they only ever receive data from the database.

```
DEVELOPMENT TIME (runs once, by the developer)
─────────────────────────────────────────────
Seed script
  └── for each of the 2,100 lessons:
        └── invoke generate-lesson (Edge Function)
              ├── nodes already in DB? → skip
              └── not in DB?
                    ├── call OpenRouter API
                    └── save nodes to DB  ✓ done forever

PRODUCTION (every user, every session)
───────────────────────────────────────
Flutter app
  ├── [1] check Hive cache
  │     HIT  → return immediately  (no network)
  │     MISS → call Edge Function
  │               └── read from DB → return nodes
  └── [2] save to Hive
              └── next open: no network call at all
```

> **OpenRouter is never called in production.** The `OPENROUTER_API_KEY` secret is only needed during the seed phase and can be removed from Edge Function secrets after all lessons are generated.

---

## 2. One Edge Function for All Languages

There is **one** Edge Function — `generate-lesson` — that handles all supported languages:

| Language   | Code         |
|------------|--------------|
| English    | `english`    |
| Spanish    | `spanish`    |
| Portuguese | `portuguese` |
| Japanese   | `japanese`   |
| Mandarin   | `chinese`    |
| Korean     | `korean`     |
| Norwegian  | `norwegian`  |

The language is stored in the `units` table (`language_target` column). The Edge Function reads it from the database and injects it into the model prompt automatically. No language-specific functions, no code duplication.

### Why not one function per language?

| Approach | Functions to deploy | Maintenance |
|---|---|---|
| One per language | 7 | Changes must be applied to all 7 |
| **One for all (this project)** | **1** | Change once, applies everywhere |

---

## 3. Full Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│  Flutter App                                                    │
│                                                                 │
│  LessonPage                                                     │
│    └── ref.watch(lessonNodesProvider(lessonId))                 │
│          └── LessonRepository                                   │
│                ├── [1] LessonLocalDataSource (Hive)             │
│                │     HIT  ──────────────────────────► return    │
│                │     MISS ──────────────────────────┐           │
│                └── [2] LessonRemoteDataSource        │           │
│                      └── supabase.functions          │           │
│                            .invoke('generate-lesson')│           │
└──────────────────────────────────────────────────────┼──────────┘
                                                       │
                    ┌──────────────────────────────────▼──────────┐
                    │  Edge Function: generate-lesson (Deno)       │
                    │                                              │
                    │  [3] Query nodes table                       │
                    │        HIT  ─────────────────────► return   │
                    │        MISS ─────────────────────┐           │
                    │  [4] Fetch lesson + unit metadata │           │
                    │        title, difficulty,         │           │
                    │        language_target            │           │
                    │  [5] Build prompt with language   │           │
                    │  [6] Call OpenRouter API  ◄───────────┘           │
                    │  [7] Insert nodes into DB                    │
                    │  [8] Return nodes                            │
                    └──────────────────────────────────────────────┘
                                        │
┌───────────────────────────────────────▼──────────────────────────┐
│  Flutter App (continued)                                          │
│                                                                   │
│  [9]  LessonLocalDataSource.saveNodes(lessonId, nodes)  → Hive   │
│  [10] LessonSessionNotifier drives UI through nodes              │
└───────────────────────────────────────────────────────────────────┘
```

### Cache hit scenarios — production only

In production, nodes are always already in the DB. The only variable is whether Hive has them locally.

| Where data is found | OpenRouter called? | Network call? | When |
|---|---|---|---|
| Hive (local) | Never | No | After first open |
| Supabase DB | Never | Yes (lightweight) | First open on this device |
| Neither | **Never in production** | — | Only during dev seed |

---

## 4. Database Schema

### 4.1 Add `language_target` to units

```sql
alter table public.units
  add column language_target text not null default 'english'
    check (language_target in (
      'english', 'spanish', 'portuguese',
      'japanese', 'chinese', 'korean', 'norwegian'
    ));
```

### 4.2 Nodes table (already in schema)

```sql
-- Nodes — minimum content unit (generated by OpenRouter)
create table public.nodes (
  id          uuid primary key default gen_random_uuid(),
  lesson_id   uuid references public.lessons(id) on delete cascade,
  order_index int not null,
  type        text not null check (type in ('explanation', 'question', 'challenge')),
  content     jsonb not null,   -- AI-generated structure (see section 6)
  created_at  timestamptz default now()
);
```

Every lesson generates exactly **15 nodes**:
- **5** nodes of type `explanation`
- **10** nodes of type `question`

---

## 5. Edge Function — `generate-lesson`

```typescript
// supabase/functions/generate-lesson/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const EXPLANATION_COUNT = 5;
const QUESTION_COUNT    = 10;

serve(async (req) => {
  const { lessonId } = await req.json();
  if (!lessonId) return new Response("lessonId required", { status: 400 });

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  // ── [1] Cache-first: nodes already generated? ────────────────────────────
  const { data: existing } = await supabase
    .from("nodes")
    .select("*")
    .eq("lesson_id", lessonId)
    .order("order_index");

  if (existing && existing.length > 0) {
    // Already generated — return immediately, no OpenRouter call
    // cached: true signals the seed script to skip this lesson
    return Response.json({ nodes: existing, cached: true });
  }

  // ── [2] Fetch lesson + unit metadata ─────────────────────────────────────
  const { data: lesson } = await supabase
    .from("lessons")
    .select("title, type, units(title, difficulty, language_target)")
    .eq("id", lessonId)
    .single();

  if (!lesson) return new Response("lesson not found", { status: 404 });

  const unit   = lesson.units as any;
  const prompt = buildPrompt(
    lesson.title,
    unit.title,
    unit.difficulty,
    unit.language_target,
  );

  // ── [3] Call OpenRouter ─────────────────────────────────────────────────────
  const OPENROUTER_API_KEY = Deno.env.get("OPENROUTER_API_KEY")!;
  const OPENROUTER_MODEL   = Deno.env.get("OPENROUTER_MODEL") ?? "google/gemini-2.0-flash-001";

  const aiRes = await fetch("https://openrouter.ai/api/v1/chat/completions", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${OPENROUTER_API_KEY}`,
      "Content-Type": "application/json",
      "HTTP-Referer": "https://draksy.app",
    },
    body: JSON.stringify({
      model:           OPENROUTER_MODEL,
      messages: [
        { role: "system", content: SYSTEM_PROMPT },
        { role: "user",   content: prompt },
      ],
      response_format: { type: "json_object" },
    }),
  });

  const aiData = await aiRes.json();
  const raw    = aiData.choices[0].message.content;
  const { explanations, questions } = JSON.parse(raw);

  // ── [4] Build nodes in order: explanations first, then questions ──────────
  const nodes = [
    ...explanations.map((content: any, i: number) => ({
      lesson_id:   lessonId,
      order_index: i,
      type:        "explanation",
      content,
    })),
    ...questions.map((content: any, i: number) => ({
      lesson_id:   lessonId,
      order_index: EXPLANATION_COUNT + i,
      type:        "question",
      content,
    })),
  ];

  // ── [5] Persist and return ────────────────────────────────────────────────
  const { data: inserted, error } = await supabase
    .from("nodes")
    .insert(nodes)
    .select();

  if (error) return new Response(error.message, { status: 500 });

  return Response.json({ nodes: inserted });
});
```

### 5.1 Prompt builder — language-aware

```typescript
const LANGUAGE_HINTS: Record<string, string> = {
  japanese:  "Use hiragana for beginners. Include romaji in parentheses. E.g. こんにちは (konnichiwa).",
  chinese:   "Use simplified characters. Include pinyin in parentheses. E.g. 你好 (nǐ hǎo).",
  korean:    "Use hangul. Include romanization in parentheses. E.g. 안녕하세요 (annyeonghaseyo).",
  norwegian: "Indicate whether the word is bokmål or nynorsk when relevant.",
  english:   "",
  spanish:   "",
  portuguese: "",
};

function buildPrompt(
  lessonTitle: string,
  unitTitle:   string,
  difficulty:  string,
  lang:        string,
): string {
  const hint = LANGUAGE_HINTS[lang] ?? "";
  return `
    Create a ${lang} lesson about "${lessonTitle}".
    Unit: "${unitTitle}". Level: ${difficulty}.
    The student is a native Brazilian Portuguese speaker.
    ${hint}
  `.trim();
}

const SYSTEM_PROMPT = `
You are a language teacher specialized in gamification.
Return ONLY valid JSON. No markdown, no extra text.
Format:
{
  "explanations": [
    {
      "type": "explanation",
      "phrase": "word or expression in the target language",
      "translation": "translation in Portuguese",
      "contextSentence": "short context sentence",
      "grammarTip": "grammar or usage tip",
      "imageKey": "dragon_neutral"
    }
  ],
  "questions": [
    {
      "type": "question",
      "question": "question in Portuguese",
      "options": [
        { "text": "option", "emoji": "👋" }
      ],
      "correctIndex": 0,
      "explanation": "short explanation of the correct answer"
    }
  ]
}
Generate exactly 5 explanations and 10 questions.
`;
```

### 5.2 Deploy

```sh
supabase functions deploy generate-lesson --project-ref <project-ref>
supabase secrets set OPENROUTER_API_KEY=<key> --project-ref <project-ref>
supabase secrets set OPENROUTER_MODEL=google/gemini-2.0-flash-001 --project-ref <project-ref>
```

---

## 6. Node Content Contract

The `content` column in `nodes` is a `jsonb` field. It always has a `type` discriminator.

### 6.1 Explanation node

Displayed as a card with the dragon mascot, the target phrase, and a grammar tip.

```json
{
  "type": "explanation",
  "phrase": "Hola",
  "translation": "Olá",
  "contextSentence": "Hola means Hello in Spanish",
  "grammarTip": "Use it any time of the day! It's casual and friendly.",
  "imageKey": "dragon_greeting"
}
```

| Field             | Type   | Description                                       |
|-------------------|--------|---------------------------------------------------|
| `type`            | string | Always `"explanation"`                            |
| `phrase`          | string | Word/expression in the target language            |
| `translation`     | string | Brazilian Portuguese translation                  |
| `contextSentence` | string | Short sentence showing the phrase in context      |
| `grammarTip`      | string | Tip or rule to help the student remember          |
| `imageKey`        | string | Key mapped to a local dragon asset (see 6.3)      |

### 6.2 Question node

Displayed as a multiple-choice exercise with emoji-illustrated options.

```json
{
  "type": "question",
  "question": "How do you say Hello?",
  "options": [
    { "text": "Adiós",   "emoji": "👋" },
    { "text": "Hola",    "emoji": "🧑" },
    { "text": "Gracias", "emoji": "🙏" },
    { "text": "Noches",  "emoji": "🌙" }
  ],
  "correctIndex": 1,
  "explanation": "Hola is the Spanish word for Hello."
}
```

| Field          | Type   | Description                                              |
|----------------|--------|----------------------------------------------------------|
| `type`         | string | Always `"question"`                                      |
| `question`     | string | The question text (in Portuguese)                        |
| `options`      | array  | Exactly 4 options, each with `text` and `emoji`          |
| `correctIndex` | int    | Zero-based index of the correct option                   |
| `explanation`  | string | Shown after the student answers — explains why           |

### 6.3 `imageKey` — dragon asset mapping

The `imageKey` is generated by the AI model and stored in every explanation node. It maps to a PNG asset on disk and determines which dragon pose is displayed and which entrance animation plays.

**Animation approach: Flutter-native (no Rive)**  
The dragon images are custom AI-generated PNGs. Animation is handled entirely by Flutter's `AnimationController` — no external animation library needed.

| `imageKey`            | Asset file                          | When the AI uses it                     |
|-----------------------|-------------------------------------|-----------------------------------------|
| `dragon_neutral`      | `dragon/dragon_neutral.png`         | Fallback / generic nodes                |
| `dragon_greeting`     | `dragon/dragon_greeting.png`        | Greetings, introductions                |
| `dragon_happy`        | `dragon/dragon_happy.png`           | Food, family, positive emotions         |
| `dragon_thinking`     | `dragon/dragon_thinking.png`        | Grammar rules, tips, cultural notes     |
| `dragon_celebrating`  | `dragon/dragon_celebrating.png`     | Injected by Flutter when answer correct |
| `dragon_sad`          | `dragon/dragon_sad.png`             | Injected by Flutter when answer wrong   |

> `dragon_celebrating` and `dragon_sad` are **never** returned by the AI model.  
> They are set directly by `LessonSessionNotifier` based on the student's answer.

**Asset path convention**

```
assets/
  images/
    dragon/
      dragon_neutral.png
      dragon_greeting.png
      dragon_happy.png
      dragon_thinking.png
      dragon_celebrating.png
      dragon_sad.png
```

**DragonAssets resolver**

```dart
// lib/core/constants/dragon_assets.dart
abstract class DragonAssets {
  static const Map<String, String> _map = {
    'dragon_neutral':     'assets/images/dragon/dragon_neutral.png',
    'dragon_greeting':    'assets/images/dragon/dragon_greeting.png',
    'dragon_happy':       'assets/images/dragon/dragon_happy.png',
    'dragon_thinking':    'assets/images/dragon/dragon_thinking.png',
    'dragon_celebrating': 'assets/images/dragon/dragon_celebrating.png',
    'dragon_sad':         'assets/images/dragon/dragon_sad.png',
  };

  static String resolve(String key) =>
      _map[key] ?? _map['dragon_neutral']!;
}
```

**DragonWidget — animated with Flutter**

The widget plays a spring entrance (`elasticOut`) every time the `imageKey` changes — i.e. on every new card. The image itself is a static PNG; the motion is the animation.

```dart
// lib/features/lessons/presentation/widgets/dragon_widget.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/dragon_assets.dart';

class DragonWidget extends StatefulWidget {
  const DragonWidget({
    super.key,
    required this.imageKey,
    this.height = 180,
  });

  final String imageKey;
  final double height;

  @override
  State<DragonWidget> createState() => _DragonWidgetState();
}

class _DragonWidgetState extends State<DragonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Spring pop-in — feels lively without being distracting
    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Quick fade so the image doesn't hard-cut on key change
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(DragonWidget old) {
    super.didUpdateWidget(old);
    // Replay animation whenever the dragon state changes
    if (old.imageKey != widget.imageKey) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Image.asset(
          DragonAssets.resolve(widget.imageKey),
          height: widget.height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
```

**How `LessonSessionNotifier` overrides the imageKey on answer**

The explanation node's `imageKey` comes from the AI model. For question nodes, the dragon reacts to the student's answer — the notifier injects `dragon_celebrating` or `dragon_sad` after the student taps an option:

```dart
// Inside LessonSessionNotifier
void selectAnswer(int index) {
  final node = nodes[state.currentIndex];
  final content = node.content as QuestionContentModel;
  final isCorrect = index == content.correctIndex;

  state = state.copyWith(
    selectedAnswer: index,
    // Override the displayed imageKey based on correctness
    dragonImageKey: isCorrect ? 'dragon_celebrating' : 'dragon_sad',
    totalXp: isCorrect ? state.totalXp + 10 : state.totalXp,
  );
}

void advance() {
  state = state.copyWith(
    currentIndex: state.currentIndex + 1,
    selectedAnswer: null,
    // Reset to the next node's imageKey (handled in LessonMobileView)
    dragonImageKey: null,
  );
}
```

**Usage in `ExplanationCard` and `QuestionCard`**

```dart
// ExplanationCard — imageKey comes from node content
DragonWidget(imageKey: content.imageKey)

// QuestionCard — imageKey comes from session state (reacts to answer)
DragonWidget(imageKey: session.dragonImageKey ?? 'dragon_neutral')
```

---

## 7. Flutter — Data Layer

### File structure

```
lib/features/lessons/
  data/
    datasources/
      lesson_remote_data_source.dart           # interface
      lesson_remote_data_source_impl.dart      # calls Edge Function via supabase.functions.invoke
      lesson_local_data_source.dart            # interface
      lesson_local_data_source_impl.dart       # Hive cache
    models/
      node_model.dart                          # wraps id + content
      node_content_model.dart                  # sealed: ExplanationContentModel | QuestionContentModel
      lesson_progress_model.dart               # @HiveType — persists per-node completion
    repositories/
      lesson_repository_impl.dart              # cache-first: local → remote
  domain/
    repositories/
      lesson_repository.dart                   # interface
    usecases/
      get_lesson_nodes.dart
      complete_node.dart
  presentation/
    providers/
      lesson_provider.dart                     # lessonNodesProvider + LessonSessionNotifier
    pages/
      lesson_page.dart
    views/
      lesson_mobile_view.dart
    widgets/
      dragon_widget.dart                       # animated PNG dragon — Flutter-native, no Rive
      explanation_card.dart
      question_card.dart

lib/core/constants/
  dragon_assets.dart                           # imageKey → asset path resolver
```

### Key Hive constants

```dart
// In AppBoxNames
static const String lessonNodes    = 'lesson_nodes_box';
static const String lessonProgress = 'lesson_progress_box';

// In HiveCacheKeys
static String lessonNodesKey(String lessonId) =>
    '${AppBoxNames.lessonNodes}__$lessonId';

static String lessonProgressKey(String unitId, String nodeId) =>
    '${AppBoxNames.lessonProgress}__${unitId}_$nodeId';
```

### Repository — cache-first pattern

```dart
@override
Future<StrautilsResponse<List<NodeModel>>> getLessonNodes(String lessonId) async {
  try {
    // 1. Hive first
    final cached = await local.getNodes(lessonId);
    if (cached != null) return StrautilsResponse.success(cached);

    // 2. Edge Function (checks DB before calling OpenRouter)
    final nodes = await remote.getLessonNodes(lessonId);

    // 3. Save to Hive for future opens
    await local.saveNodes(lessonId, nodes);

    return StrautilsResponse.success(nodes);
  } catch (e) {
    return StrautilsResponse.error(e.toString());
  }
}
```

### Remote data source — Flutter side

```dart
@override
Future<List<NodeModel>> getLessonNodes(String lessonId) async {
  // ✅ Always via Edge Function — NEVER call OpenRouter directly from Flutter
  final response = await _client.functions.invoke(
    'generate-lesson',
    body: {'lessonId': lessonId},
  );
  final nodes = (response.data['nodes'] as List<dynamic>);
  return nodes.map((n) => NodeModel.fromJson(n as Map<String, dynamic>)).toList();
}
```

---

## 8. Session Flow — Presentation Layer

```
LessonPage
  ├── lessonNodesProvider(lessonId)
  │     AsyncValue<List<NodeModel>>
  │       loading → skeleton UI
  │       error   → ErrorRetryWidget
  │       data    → pass to LessonMobileView as LessonViewData
  │
  └── LessonSessionNotifier
        state: LessonSessionState {
          currentIndex:   0..14   (5 explanations + 10 questions)
          selectedAnswer: int?    (null until user taps)
          dragonImageKey: String? (null = use node's imageKey; set to celebrating/sad on answer)
          totalXp:        int     (accumulated this session)
        }

        actions:
          advance()         → currentIndex++, dragonImageKey = null
          selectAnswer(int) → selectedAnswer = int, dragonImageKey = celebrating | sad
          addXp(int)        → totalXp += int
          reset()           → back to initial state
```

The view (`LessonMobileView`) is always a `StatelessWidget`.  
It receives a `LessonViewData` from the page and renders the correct card based on the current node's `type`:

```dart
// Pseudo-code inside LessonMobileView.build()
final node    = viewData.nodes[viewData.session.currentIndex];
final imgKey  = viewData.session.dragonImageKey   // set on answer (celebrating/sad)
             ?? (node.content is ExplanationContentModel
                  ? (node.content as ExplanationContentModel).imageKey
                  : 'dragon_neutral');             // default for question nodes

return Column(
  children: [
    DragonWidget(imageKey: imgKey),   // animates on every key change
    switch (node.content) {
      ExplanationContentModel() => ExplanationCard(content: node.content),
      QuestionContentModel()    => QuestionCard(content: node.content),
    },
  ],
);
```

---

## 9. Progress — Offline-first

Node completion is saved locally first, then synced to Supabase in the background.  
If the sync fails (no network), the local record remains and the UI is not affected.

```dart
@override
Future<StrautilsResponse<void>> completeNode({...}) async {
  try {
    // 1. Write to Hive immediately — UI never waits for network
    await local.saveProgress(LessonProgressModel(...));

    // 2. Sync to Supabase in background
    await remote.saveNodeProgress(...);

    return StrautilsResponse.success(null);
  } catch (e) {
    // Local record is already saved — user progress is never lost
    return StrautilsResponse.error(e.toString());
  }
}
```

---

## 10. Security Rules

| Rule | Detail |
|---|---|
| `OPENROUTER_API_KEY` — development only | Set during seed phase. Can be removed from secrets after all lessons are generated. |
| `OPENROUTER_MODEL` — development only | Model string, e.g. `google/gemini-2.0-flash-001`. Swap to any OpenRouter-supported model. |
| `SUPABASE_SERVICE_ROLE_KEY` never in Flutter | Edge Function only |
| Flutter only holds `supabaseUrl` and `supabaseAnonKey` | Defined in `AppKeys` |
| OpenRouter always called via Edge Function | Never directly from Flutter — even during development |
| Users only ever read from DB | No user action can trigger an OpenRouter call |

```dart
// ✅ Correct — Flutter invokes the Edge Function
await _client.functions.invoke('generate-lesson', body: {'lessonId': lessonId});

// ❌ Forbidden — direct OpenRouter call from Flutter
await http.post(Uri.parse('https://generativelanguage.googleapis.com/...'));
```

---

## 11. Lesson Structure

Each language has three levels. The total number of lessons is fixed and the same across all 7 languages.

| Level    | Lessons | Nodes per lesson | Total nodes per language |
|----------|---------|------------------|--------------------------|
| Basic    | 50      | 15 (5 exp + 10 q)| 750                      |
| Medium   | 100     | 15 (5 exp + 10 q)| 1,500                    |
| Advanced | 150     | 15 (5 exp + 10 q)| 2,250                    |
| **Total**| **300** |                  | **4,500**                |

Across all 7 languages:

| Metric | Value |
|---|---|
| Total lessons | 300 × 7 = **2,100** |
| Total nodes in DB (fully generated) | 2,100 × 15 = **31,500** |
| Max OpenRouter calls ever | **2,100** (one per lesson, one-time) |

> **Important:** OpenRouter is only called when a student first opens a lesson no one has ever opened before. Once a lesson is generated, every student who opens it afterwards gets it from the DB — no AI cost, no matter how many users.

### DB schema — levels table

```sql
create table public.levels (
  id         uuid primary key default gen_random_uuid(),
  name       text not null check (name in ('basic', 'medium', 'advanced')),
  order_index int not null,  -- 1, 2, 3
  lesson_count int not null, -- 50, 100, 150
  language_target text not null
);
```

### Lesson count enforcement in the Edge Function

```typescript
// The Edge Function does not enforce lesson count — that is a DB/content concern.
// The function simply generates nodes for whatever lessonId is passed.
// Lesson creation (seeding all 300 lessons per language) should be done
// via a separate seed script or Supabase migration, not at runtime.
```

### Seed script — development only

The seed script is run **once by the developer** before releasing the app.  
It is not deployed and never runs in production.

```typescript
// scripts/seed-all-lessons.ts
// Run with: deno run --allow-net --allow-env scripts/seed-all-lessons.ts

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

const DELAY_MS         = 300;   // stay under OpenRouter rate limit
const REQUESTS_PER_DAY = 1_500; // OpenRouter daily limit (adjust per plan)

const { data: lessons, error } = await supabase
  .from("lessons")
  .select("id, title");

if (error || !lessons) {
  console.error("Failed to fetch lessons:", error?.message);
  Deno.exit(1);
}

console.log(`\nSeeding ${lessons.length} lessons...\n`);

let generated = 0;
let skipped   = 0;

for (const [i, lesson] of lessons.entries()) {
  const { data, error: fnError } = await supabase.functions.invoke(
    "generate-lesson",
    { body: { lessonId: lesson.id } },
  );

  if (fnError) {
    console.error(`✗ [${i + 1}/${lessons.length}] ${lesson.title} — ${fnError.message}`);
  } else if (data.cached) {
    skipped++;
    console.log(`↩ [${i + 1}/${lessons.length}] ${lesson.title} — already in DB, skipped`);
  } else {
    generated++;
    console.log(`✓ [${i + 1}/${lessons.length}] ${lesson.title} — generated`);
  }

  await new Promise((r) => setTimeout(r, DELAY_MS));
}

console.log(`\nDone. Generated: ${generated} | Skipped: ${skipped} | Total: ${lessons.length}`);
```

> The Edge Function returns `{ cached: true }` when it finds nodes already in the DB, so the script is **safe to re-run** — it skips already-generated lessons and only calls OpenRouter for the missing ones.

---

## 12. OpenRouter Cost Estimate

OpenRouter is only called during the **seed phase** — never in production.

| Level    | Lessons | Languages | OpenRouter calls (seed, one-time) |
|----------|---------|-----------|-------------------------------|
| Basic    | 50      | 7         | 350                           |
| Medium   | 100     | 7         | 700                           |
| Advanced | 150     | 7         | 1,050                         |
| **Total**| **300** | **7**     | **2,100**                     |

OpenRouter allows up to **1,500 requests/day** on the free tier (adjust based on your plan).    
Full seed takes approximately **2 days** at the free tier rate.  
The seed script is re-runnable — it skips already-generated lessons safely.

**Production cost: $0.** All data is served from Supabase DB and Hive.

---

## 13. Checklist — Before Starting

### Database
```
[ ] Add language_target column to units table
[ ] Create levels table with basic (50), medium (100), advanced (150) lesson counts
[ ] Seed all 300 lessons per language in the lessons table (title, unit, level)
```

### Flutter
```
[ ] Register LessonProgressModel HiveType adapter in main.dart _registerHiveAdapters()
    (assign the next available typeId — check existing registrations first)
[ ] Add AppBoxNames.lessonNodes and AppBoxNames.lessonProgress
[ ] Add HiveCacheKeys.lessonNodesKey() and HiveCacheKeys.lessonProgressKey()
[ ] Add DragonAssets class (lib/core/constants/dragon_assets.dart)
[ ] Add all 6 dragon PNGs to assets/images/dragon/ and declare in pubspec.yaml
[ ] Create DragonWidget (lib/features/lessons/presentation/widgets/dragon_widget.dart)
[ ] Add dragonImageKey field to LessonSessionState
[ ] Run: dart run build_runner build --delete-conflicting-outputs
```

### Edge Function
```
[ ] Deploy: supabase functions deploy generate-lesson --project-ref <ref>
[ ] Set secret: supabase secrets set OPENROUTER_API_KEY=<key> --project-ref <ref>
[ ] Set secret: supabase secrets set OPENROUTER_MODEL=google/gemini-2.0-flash-001 --project-ref <ref>
```

### Seed (development only — run once)
```
[ ] Run seed script: deno run --allow-net --allow-env scripts/seed-all-lessons.ts
    Day 1: ~1,500 lessons generated (OpenRouter free tier limit)
    Day 2: remaining ~600 lessons generated
[ ] Verify: all 2,100 lessons have nodes in the nodes table
[ ] Optional: remove OPENROUTER_API_KEY from Edge Function secrets after seed is complete
```

### QA
```
[ ] Open a lesson on a fresh device → confirm it loads from DB (no OpenRouter call)
[ ] Open the same lesson again → confirm it loads from Hive (no network call)
[ ] Run seed script again → confirm all lessons are skipped (cached: true)
```