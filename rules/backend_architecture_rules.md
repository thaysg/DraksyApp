# Backend Architecture — Draksy

> Definitive reference document for all implementation touching external services.
> Any code that accesses Supabase, Firebase, OpenRouter, or push must follow this document.

---

# 1. Service Stack

```
Authentication        → Supabase Auth (Google OAuth)
Database              → Supabase PostgreSQL
Server-side logic     → Supabase Edge Functions (Deno / TypeScript)
Lesson generation     → OpenRouter API       ← via Edge Function (API key NEVER in the app)
Push Notifications    → Firebase Cloud Messaging v1 ← only Firebase usage
```

## Why Firebase is still in the stack

Firebase is kept **exclusively for FCM (push)**. There is no Firestore, Firebase Auth, Remote Config, or any other Firebase service in this project.

```
❌ REMOVED
  Firebase Auth         → replaced by Supabase Auth
  Firestore             → replaced by Supabase PostgreSQL
  database_helper.dart  → legacy SQLite file; still present in the codebase but must not be used for new code

✅ KEPT
  firebase_core         → required for all Firebase services
  firebase_messaging    → push notifications (Android + iOS)
  firebase_analytics    → event tracking (AnalyticsService wrapper, analyticsServiceProvider)
  firebase_crashlytics  → crash reporting (CrashService wrapper, crashServiceProvider)
  firebase_options.dart → minimal config for Firebase
```

> **Important:** The legacy FCM API (`/fcm/send` with `FCM_SERVER_KEY`) was discontinued by Google in July 2024. This project uses exclusively the **FCM v1 API** with OAuth2 authentication via Service Account.

---

# 2. Supabase — Setup

## 2.1 Flutter packages

```yaml
# pubspec.yaml
dependencies:
  supabase_flutter: ^2.x.x
  google_sign_in: ^6.x.x
  firebase_core: ^3.x.x
  firebase_messaging: ^15.x.x
  firebase_analytics: ^11.x.x
  firebase_crashlytics: ^4.x.x
```

## 2.2 Keys — `app_keys.dart`

```dart
// lib/core/constants/app_keys.dart
abstract class AppKeys {
  AppKeys._();

  // Supabase — public keys, safe to include in code
  static const String supabaseUrl     = 'https://<project-ref>.supabase.co';
  static const String supabaseAnonKey = '<anon-key>';

  // Google OAuth — required for sign-in
  static const String googleServerClientId = '<web-client-id>';
}
```

> `SERVICE_ROLE` key, `OPENROUTER_API_KEY`, `OPENROUTER_MODEL`, and `FCM_SERVICE_ACCOUNT_JSON` are **server secrets**.
> They never go into Flutter — they live only in Edge Function environment variables.

## 2.3 Initialization — `main.dart`

```dart
// Required order:
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
await Supabase.initialize(
  url: AppKeys.supabaseUrl,
  anonKey: AppKeys.supabaseAnonKey,
);
```

## 2.4 Client provider

```dart
// lib/core/providers/supabase_providers.dart
@riverpod
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;
```

---

# 3. Supabase Auth — Google OAuth

## 3.1 Supabase Dashboard configuration

1. Authentication → Providers → Google → **Enable**
2. Add **Web Client ID** and **Web Client Secret** from Google Cloud Console
3. Under "Redirect URLs" add: `io.supabase.<project-ref>://login-callback/`

## 3.2 Flutter implementation

```dart
// features/auth/data/datasources/auth_remote_data_source_impl.dart

// ── Google OAuth ──────────────────────────────────────────────────────────────
Future<UserModel?> signInWithGoogle() async {
  final googleUser = await GoogleSignIn(
    serverClientId: AppKeys.googleServerClientId,
  ).signIn();

  if (googleUser == null) return null;

  final googleAuth = await googleUser.authentication;

  final response = await Supabase.instance.client.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: googleAuth.idToken!,
    accessToken: googleAuth.accessToken,
  );

  if (response.user == null) return null;
  return UserModel.fromSupabaseUser(response.user!);
}

// ── Email / Password ──────────────────────────────────────────────────────────
Future<UserModel?> signInWithEmail(String email, String password) async {
  final response = await Supabase.instance.client.auth.signInWithPassword(
    email: email,
    password: password,
  );
  if (response.user == null) return null;
  return UserModel.fromSupabaseUser(response.user!);
}

Future<UserModel?> signUpWithEmailAndPassword(
  String email,
  String password,
  String displayName,
) async {
  final response = await Supabase.instance.client.auth.signUp(
    email: email,
    password: password,
    data: {'full_name': displayName},
  );
  if (response.user == null) return null;
  return UserModel.fromSupabaseUser(response.user!);
}

// ── Common ────────────────────────────────────────────────────────────────────
Future<void> signOut() async {
  await GoogleSignIn().signOut();
  await Supabase.instance.client.auth.signOut();
}

Stream<UserModel?> get userChanges =>
    Supabase.instance.client.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      return user != null ? UserModel.fromSupabaseUser(user) : null;
    });
```

---

# 4. Supabase Database — Full Schema

## 4.1 User profile

```sql
-- Extends auth.users — created automatically via trigger (see section 4.10)
create table public.profiles (
  id             uuid primary key references auth.users(id) on delete cascade,
  username       text,
  avatar_url     text,
  level          int default 1,
  xp             int default 0,
  lives          int default 5,
  streak         int default 0,
  longest_streak int default 0,
  language       text default 'pt',
  created_at     timestamptz default now(),
  updated_at     timestamptz default now()
);
```

## 4.2 User preferences

```sql
create table public.user_preferences (
  user_id                uuid primary key references auth.users(id) on delete cascade,
  preferred_study_time   time,
  timezone               text default 'UTC',
  notifications_enabled  boolean default true,
  daily_goal_minutes     int default 10
);
```

## 4.3 Content structure

```sql
-- Units (groups of lessons)
create table public.units (
  id          uuid primary key default gen_random_uuid(),
  order_index int not null,
  title       text not null,
  description text,
  difficulty  text not null check (difficulty in ('beginner','intermediate','advanced')),
  created_at  timestamptz default now()
);

-- Lessons (groups of nodes)
create table public.lessons (
  id          uuid primary key default gen_random_uuid(),
  unit_id     uuid references public.units(id) on delete cascade,
  order_index int not null,
  title       text not null,
  type        text not null check (type in ('vocabulary','grammar','listening','speaking','review')),
  created_at  timestamptz default now()
);

-- Nodes — minimum content unit (generated by OpenRouter)
create table public.nodes (
  id          uuid primary key default gen_random_uuid(),
  lesson_id   uuid references public.lessons(id) on delete cascade,
  order_index int not null,
  type        text not null check (type in ('explanation','question','challenge')),
  content     jsonb not null,   -- AI-generated structure (see section 6.2)
  created_at  timestamptz default now()
);
```

## 4.4 Per-node progress (granular)

```sql
-- Tracks which node each user has completed — different from user_progress (streak/total XP)
create table public.node_progress (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references auth.users(id) on delete cascade,
  node_id      uuid references public.nodes(id) on delete cascade,
  lesson_id    uuid references public.lessons(id) on delete cascade,
  unit_id      uuid references public.units(id) on delete cascade,
  is_completed boolean default false,
  xp_earned    int default 0,
  accuracy     float8 default 0.0,
  completed_at timestamptz,
  unique(user_id, node_id)
);
```

## 4.5 Aggregated user progress

```sql
-- Totals and streak — updated after each node is completed
create table public.user_progress (
  user_id        uuid primary key references auth.users(id) on delete cascade,
  last_study_at  timestamptz,
  streak         int default 0,
  longest_streak int default 0,
  total_lessons  int default 0,
  total_xp       int default 0,
  updated_at     timestamptz default now()
);
```

## 4.6 Daily challenge

```sql
create table public.daily_challenges (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references auth.users(id) on delete cascade,
  date         date not null default current_date,
  is_completed boolean default false,
  content      jsonb not null,   -- AI-generated (same format as nodes)
  xp_earned    int default 0,
  unique(user_id, date)
);
```

## 4.7 FCM tokens

```sql
create table public.user_devices (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references auth.users(id) on delete cascade,
  fcm_token    text not null,
  platform     text not null check (platform in ('android','ios')),
  app_version  text,
  last_seen_at timestamptz default now(),
  created_at   timestamptz default now(),
  unique(user_id, fcm_token)
);
```

## 4.8 Notification log

```sql
create table public.notifications_log (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid references auth.users(id) on delete cascade,
  type           text not null check (type in (
    'DAILY_REMINDER','INACTIVITY_1D','INACTIVITY_3D','STREAK_WARNING'
  )),
  sent_at        timestamptz default now(),
  delivered      boolean default false,
  fcm_message_id text
);
```

## 4.9 Streak Freeze (premium feature)

```sql
create table public.streak_freeze (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid references auth.users(id) on delete cascade,
  used_at    date,
  expires_at date
);
```

## 4.10 Trigger — auto-create profile on signup

```sql
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, username, avatar_url)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'full_name', 'User'),
    new.raw_user_meta_data->>'avatar_url'
  );

  insert into public.user_progress (user_id) values (new.id);
  insert into public.user_preferences (user_id) values (new.id);

  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
```

## 4.11 Indexes

```sql
create index idx_user_progress_last_study    on public.user_progress(last_study_at);
create index idx_notifications_log_user_type on public.notifications_log(user_id, type, sent_at desc);
create index idx_user_devices_user_id        on public.user_devices(user_id);
create index idx_user_devices_last_seen      on public.user_devices(last_seen_at);
create index idx_node_progress_user_unit     on public.node_progress(user_id, unit_id);
create index idx_node_progress_user_lesson   on public.node_progress(user_id, lesson_id);
```

---

# 5. Row Level Security (RLS)

RLS replaces a security backend — each user only accesses their own data, without a custom server.

**Rule: RLS is mandatory on every table that contains user data.**

```sql
-- ─── profiles ────────────────────────────────────────────────────────────────
alter table public.profiles enable row level security;
create policy "profiles: user manages own"
  on public.profiles for all using (auth.uid() = id);

-- ─── user_preferences ────────────────────────────────────────────────────────
alter table public.user_preferences enable row level security;
create policy "preferences: user manages own"
  on public.user_preferences for all using (auth.uid() = user_id);

-- ─── user_progress ───────────────────────────────────────────────────────────
alter table public.user_progress enable row level security;
create policy "progress: user manages own"
  on public.user_progress for all using (auth.uid() = user_id);

-- ─── node_progress ───────────────────────────────────────────────────────────
alter table public.node_progress enable row level security;
create policy "node_progress: user manages own"
  on public.node_progress for all using (auth.uid() = user_id);

-- ─── daily_challenges ────────────────────────────────────────────────────────
alter table public.daily_challenges enable row level security;
create policy "daily_challenges: user manages own"
  on public.daily_challenges for all using (auth.uid() = user_id);

-- ─── user_devices ────────────────────────────────────────────────────────────
alter table public.user_devices enable row level security;
create policy "devices: user manages own"
  on public.user_devices for all using (auth.uid() = user_id);

-- ─── notifications_log ───────────────────────────────────────────────────────
alter table public.notifications_log enable row level security;
create policy "notifications_log: user reads own"
  on public.notifications_log for select using (auth.uid() = user_id);

-- ─── streak_freeze ───────────────────────────────────────────────────────────
alter table public.streak_freeze enable row level security;
create policy "streak_freeze: user manages own"
  on public.streak_freeze for all using (auth.uid() = user_id);

-- ─── Public content (units, lessons, nodes) ──────────────────────────────────
alter table public.units   enable row level security;
alter table public.lessons enable row level security;
alter table public.nodes   enable row level security;

create policy "units: public read"   on public.units   for select using (true);
create policy "lessons: public read" on public.lessons for select using (true);
create policy "nodes: public read"   on public.nodes   for select using (true);
```

---

# 6. OpenRouter API — Lesson Generation

## 6.1 Core rule

The `OPENROUTER_API_KEY` **can never be in the Flutter app**. The Edge Function is the only contact point with the OpenRouter API. Content is always saved to the database before being served to Flutter — never generated on the fly at read time.

## 6.2 Expected JSON contract from the AI model

All generated content (nodes and daily challenges) follows this contract:

```json
{
  "title": "string",
  "explanation": "string",
  "nodes": [
    {
      "type": "question",
      "question": "What is the correct form of the verb?",
      "options": ["He go", "He goes", "He going", "He gone"],
      "correctIndex": 1,
      "explanation": "'Goes' is used with third person singular in simple present."
    },
    {
      "type": "challenge",
      "instruction": "Translate the sentence below:",
      "source": "Eu preciso estudar todos os dias.",
      "correctAnswer": "I need to study every day.",
      "alternatives": ["I need study every day.", "I needs to study every day."]
    }
  ]
}
```

This JSON is stored in the `content jsonb` column of `nodes` and `daily_challenges`.
Flutter reads from the database — **it never calls OpenRouter directly**.

## 6.3 Edge Function — `generate-lesson`

```typescript
// supabase/functions/generate-lesson/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const OPENROUTER_API_KEY = Deno.env.get("OPENROUTER_API_KEY")!;
const OPENROUTER_MODEL   = Deno.env.get("OPENROUTER_MODEL") ?? "google/gemini-2.0-flash-001";
const OPENROUTER_URL     = "https://openrouter.ai/api/v1/chat/completions";

serve(async (req) => {
  const authHeader = req.headers.get("Authorization");
  if (!authHeader) {
    return new Response(JSON.stringify({ error: "Unauthorized" }), { status: 401 });
  }

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: authHeader } } }
  );

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return new Response("Unauthorized", { status: 401 });

  const { lessonType, difficulty, topic, unitId, lessonId } = await req.json();

  const prompt = buildLessonPrompt(lessonType, difficulty, topic);

  const aiResponse = await fetch(OPENROUTER_URL, {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${OPENROUTER_API_KEY}`,
      "Content-Type": "application/json",
      "HTTP-Referer": "https://draksy.app",
    },
    body: JSON.stringify({
      model: OPENROUTER_MODEL,
      messages: [{ role: "user", content: prompt }],
      response_format: { type: "json_object" },
    }),
  });

  const aiData = await aiResponse.json();
  const rawContent = aiData.choices?.[0]?.message?.content;

  if (!rawContent) {
    return new Response(JSON.stringify({ error: "OpenRouter returned empty response" }), {
      status: 500,
    });
  }

  const parsed = JSON.parse(rawContent);

  // Save generated nodes to database
  const nodesToInsert = parsed.nodes.map((node: any, index: number) => ({
    lesson_id: lessonId,
    unit_id: unitId,
    order_index: index,
    type: node.type,
    content: node,
  }));

  const { error } = await supabase.from("nodes").insert(nodesToInsert);
  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }

  return new Response(JSON.stringify(parsed), {
    headers: { "Content-Type": "application/json" },
  });
});

function buildLessonPrompt(lessonType: string, difficulty: string, topic: string): string {
  return `
You are an English language teaching assistant.
Generate a ${lessonType} lesson for ${difficulty} level about "${topic}" for Brazilian Portuguese speakers.

Respond ONLY with a valid JSON object following this exact structure — no markdown, no preamble:
{
  "title": "string",
  "explanation": "string (in Portuguese, explaining the concept)",
  "nodes": [
    {
      "type": "question",
      "question": "string",
      "options": ["string", "string", "string", "string"],
      "correctIndex": 0,
      "explanation": "string (why this answer is correct, in Portuguese)"
    }
  ]
}

Rules:
- Generate exactly 5 nodes
- Mix "question" and "challenge" types
- All explanations in Portuguese
- Questions and challenges in English
- correctIndex must be 0, 1, 2 or 3
- Only valid JSON, nothing else
`.trim();
}
```

## 6.4 Edge Function — `generate-daily-challenge`

```typescript
// supabase/functions/generate-daily-challenge/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const OPENROUTER_API_KEY = Deno.env.get("OPENROUTER_API_KEY")!;
const OPENROUTER_MODEL   = Deno.env.get("OPENROUTER_MODEL") ?? "google/gemini-2.0-flash-001";
const OPENROUTER_URL     = "https://openrouter.ai/api/v1/chat/completions";

serve(async (req) => {
  const authHeader = req.headers.get("Authorization");
  if (!authHeader) return new Response("Unauthorized", { status: 401 });

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: authHeader } } }
  );

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return new Response("Unauthorized", { status: 401 });

  const today = new Date().toISOString().split("T")[0];

  // Return existing challenge if already generated today
  const { data: existing } = await supabase
    .from("daily_challenges")
    .select("*")
    .eq("user_id", user.id)
    .eq("date", today)
    .single();

  if (existing) {
    return new Response(JSON.stringify(existing), {
      headers: { "Content-Type": "application/json" },
    });
  }

  const prompt = `
You are an English language teaching assistant.
Generate a short English daily challenge for a Brazilian Portuguese speaker.
Respond ONLY with valid JSON, no markdown:
{
  "title": "string",
  "explanation": "string (in Portuguese)",
  "nodes": [
    { "type": "question", "question": "string", "options": ["","","",""], "correctIndex": 0, "explanation": "string" }
  ]
}
Generate 3 nodes. Mix question and challenge types. Only valid JSON.
`.trim();

  const res = await fetch(OPENROUTER_URL, {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${OPENROUTER_API_KEY}`,
      "Content-Type": "application/json",
      "HTTP-Referer": "https://draksy.app",
    },
    body: JSON.stringify({
      model: OPENROUTER_MODEL,
      messages: [{ role: "user", content: prompt }],
      response_format: { type: "json_object" },
    }),
  });

  const aiData = await res.json();
  const content = JSON.parse(aiData.choices[0].message.content);

  const { data: challenge } = await supabase
    .from("daily_challenges")
    .insert({ user_id: user.id, date: today, content })
    .select()
    .single();

  return new Response(JSON.stringify(challenge), {
    headers: { "Content-Type": "application/json" },
  });
});
```

## 6.5 Flutter call

```dart
// features/lessons/data/datasources/lesson_remote_data_source_impl.dart

Future<void> generateLesson({
  required String lessonType,
  required String difficulty,
  required String topic,
  required String unitId,
  required String lessonId,
}) async {
  final response = await Supabase.instance.client.functions.invoke(
    'generate-lesson',
    body: {
      'lessonType': lessonType,
      'difficulty': difficulty,
      'topic': topic,
      'unitId': unitId,
      'lessonId': lessonId,
    },
  );

  if (response.status != 200) {
    throw LessonGenerationException(response.data.toString());
  }
  // Nodes are already saved in the database by the Edge Function.
  // Flutter just reloads nodes from Supabase after this returns.
}

Future<DailyChallengeModel> getDailyChallenge() async {
  final response = await Supabase.instance.client.functions.invoke(
    'generate-daily-challenge',
  );

  if (response.status != 200) {
    throw LessonGenerationException(response.data.toString());
  }

  return DailyChallengeModel.fromJson(response.data as Map<String, dynamic>);
}
```

---

# 7. Firebase Cloud Messaging — Push Notifications

## 7.1 Full flow

```
Flutter (FirebaseMessaging.getToken())
  ↓
Save token to user_devices (Supabase) — upsert
  ↓
CRON Edge Function (hourly)
  ↓
Anti-spam check (notifications_log)
  ↓
Send via FCM v1 API (OAuth2 Service Account)
  ↓
Log result + auto-remove invalid tokens
```

## 7.2 Notification types and cooldown rules

| Type | Trigger | Cooldown |
|---|---|---|
| `DAILY_REMINDER` | Preferred study time reached | 20h minimum between sends |
| `INACTIVITY_1D` | 24h without studying | Once per window |
| `INACTIVITY_3D` | 72h without studying | Once per window |
| `STREAK_WARNING` | Streak about to be lost (< 3h left) | Once per day |

**Anti-spam rules:**
- Never send more than **2 notifications per day** per user.
- Always check `notifications_log` before sending — skip if same type was sent within cooldown.
- Always respect `notifications_enabled = false`.
- Tokens with `last_seen_at` older than 60 days are ignored and removed automatically.

## 7.3 `PushNotificationService` — Flutter

```dart
// lib/core/services/push_notification_service.dart

class PushNotificationService {
  const PushNotificationService(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  Future<void> initialize() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await _saveToken(token);

    // Update token whenever FCM refreshes it
    FirebaseMessaging.instance.onTokenRefresh.listen(_saveToken);

    // App in foreground — show in-app banner
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // App in background — opened by tapping notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // App was terminated — opened by notification
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _handleNotificationTap(initial);
  }

  Future<void> _saveToken(String token) async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    await _supabaseClient.from('user_devices').upsert(
      {
        'user_id': userId,
        'fcm_token': token,
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'app_version': packageInfo.version,  // via package_info_plus
        'last_seen_at': DateTime.now().toIso8601String(),
      },
      onConflict: 'user_id,fcm_token',
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show via flutter_local_notifications or custom overlay
    // Never auto-redirect — user is already using the app
  }

  void _handleNotificationTap(RemoteMessage message) {
    final route = message.data['route'] as String?;
    if (route != null) {
      // Navigate via GoRouter
      // e.g.: appRouter.go(route);
    }
  }
}
```

## 7.4 Edge Function — `send-push`

```typescript
// supabase/functions/send-push/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { create, getNumericDate } from "https://deno.land/x/djwt@v2.8/mod.ts";

const FCM_PROJECT_ID  = Deno.env.get("FCM_PROJECT_ID")!;
const SERVICE_ACCOUNT = JSON.parse(Deno.env.get("FCM_SERVICE_ACCOUNT_JSON")!);
const FCM_URL = `https://fcm.googleapis.com/v1/projects/${FCM_PROJECT_ID}/messages:send`;

serve(async (req) => {
  const { userId, title, body, data, type } = await req.json();

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!   // service role — bypasses RLS
  );

  // Fetch active tokens (last 60 days only)
  const cutoff = new Date(Date.now() - 60 * 24 * 3600 * 1000).toISOString();
  const { data: devices } = await supabase
    .from("user_devices")
    .select("fcm_token")
    .eq("user_id", userId)
    .gte("last_seen_at", cutoff);

  if (!devices?.length) return new Response(JSON.stringify({ sent: 0 }));

  const accessToken = await getFCMAccessToken();
  let sent = 0;

  for (const device of devices) {
    try {
      const res = await fetch(FCM_URL, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message: {
            token: device.fcm_token,
            notification: { title, body },
            data: { ...(data ?? {}), type: type ?? "" },
            android: { priority: "high" },
            apns: { headers: { "apns-priority": "10" } },
          },
        }),
      });

      const json = await res.json();

      // Log result
      await supabase.from("notifications_log").insert({
        user_id: userId,
        type: type ?? "MANUAL",
        fcm_message_id: json.name ?? null,
        delivered: res.ok,
      });

      // Invalid token → remove automatically
      const isUnregistered = json?.error?.details?.some(
        (d: any) => d.errorCode === "UNREGISTERED"
      );
      if (isUnregistered) {
        await supabase
          .from("user_devices")
          .delete()
          .eq("fcm_token", device.fcm_token);
      }

      if (res.ok) sent++;
    } catch (err) {
      console.error(`[FCM] Failed for token ${device.fcm_token}:`, err);
    }
  }

  return new Response(JSON.stringify({ sent }));
});

// ─── OAuth2 for FCM v1 ──────────────────────────────────────────────────────
// Generates an access token signed with the Firebase Service Account
async function getFCMAccessToken(): Promise<string> {
  const privateKeyPem = SERVICE_ACCOUNT.private_key;
  const clientEmail   = SERVICE_ACCOUNT.client_email;

  const keyData = pemToArrayBuffer(privateKeyPem);
  const cryptoKey = await crypto.subtle.importKey(
    "pkcs8",
    keyData,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const jwt = await create(
    { alg: "RS256", typ: "JWT" },
    {
      iss: clientEmail,
      sub: clientEmail,
      aud: "https://oauth2.googleapis.com/token",
      iat: getNumericDate(0),
      exp: getNumericDate(3600),
      scope: "https://www.googleapis.com/auth/firebase.messaging",
    },
    cryptoKey
  );

  const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth2:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  const tokenData = await tokenRes.json();
  return tokenData.access_token;
}

function pemToArrayBuffer(pem: string): ArrayBuffer {
  const b64 = pem
    .replace(/-----BEGIN PRIVATE KEY-----/, "")
    .replace(/-----END PRIVATE KEY-----/, "")
    .replace(/\n/g, "");
  const binary = atob(b64);
  const buffer = new ArrayBuffer(binary.length);
  const view = new Uint8Array(buffer);
  for (let i = 0; i < binary.length; i++) view[i] = binary.charCodeAt(i);
  return buffer;
}
```

## 7.5 Edge Function — `engagement-cron` (runs hourly)

```typescript
// supabase/functions/engagement-cron/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async () => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  const now = new Date();

  const { data: users } = await supabase
    .from("user_progress")
    .select(`
      user_id, last_study_at, streak,
      user_preferences(preferred_study_time, timezone, notifications_enabled),
      user_devices(fcm_token, last_seen_at)
    `);

  if (!users) return new Response("No users", { status: 200 });

  for (const user of users) {
    if (!user.user_preferences?.notifications_enabled) continue;

    const activeDevices = user.user_devices?.filter((d: any) => {
      const days = (now.getTime() - new Date(d.last_seen_at).getTime()) / 86400000;
      return days <= 60;
    }) ?? [];

    if (!activeDevices.length) continue;

    const hoursInactive = user.last_study_at
      ? (now.getTime() - new Date(user.last_study_at).getTime()) / 3600000
      : Infinity;

    // Streak about to be lost (< 3h left)
    if (user.streak > 0 && hoursInactive >= 21 && hoursInactive < 24) {
      if (!(await wasRecentlySent(supabase, user.user_id, "STREAK_WARNING", 20))) {
        await triggerPush(user.user_id, "⚡ Your streak is ending!", `You have ${user.streak} days in a row. Study now to keep it!`, "STREAK_WARNING");
      }
    }

    // 1 day inactive
    if (hoursInactive >= 24 && hoursInactive < 48) {
      if (!(await wasRecentlySent(supabase, user.user_id, "INACTIVITY_1D", 20))) {
        await triggerPush(user.user_id, "Draksy missed you 👀", "Come back and continue your journey!", "INACTIVITY_1D");
      }
    }

    // 3 days inactive
    if (hoursInactive >= 72) {
      if (!(await wasRecentlySent(supabase, user.user_id, "INACTIVITY_3D", 48))) {
        await triggerPush(user.user_id, "It's been 3 days... 😢", "Don't give up now! Just 5 minutes a day makes a difference.", "INACTIVITY_3D");
      }
    }

    // Daily reminder at preferred study time
    if (isPreferredTime(user.user_preferences)) {
      if (!(await wasRecentlySent(supabase, user.user_id, "DAILY_REMINDER", 20))) {
        await triggerPush(user.user_id, "Time to study! 📚", "Your daily challenge is waiting.", "DAILY_REMINDER");
      }
    }
  }

  return new Response(JSON.stringify({ ok: true }));
});

async function wasRecentlySent(
  supabase: any,
  userId: string,
  type: string,
  withinHours: number
): Promise<boolean> {
  const cutoff = new Date(Date.now() - withinHours * 3600000).toISOString();
  const { data } = await supabase
    .from("notifications_log")
    .select("id")
    .eq("user_id", userId)
    .eq("type", type)
    .gte("sent_at", cutoff)
    .limit(1);
  return (data?.length ?? 0) > 0;
}

async function triggerPush(userId: string, title: string, body: string, type: string) {
  await fetch(`${Deno.env.get("SUPABASE_URL")}/functions/v1/send-push`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ userId, title, body, type }),
  });
}

function isPreferredTime(pref: any): boolean {
  if (!pref?.preferred_study_time) return false;
  const userNow = new Date(
    new Date().toLocaleString("en-US", { timeZone: pref.timezone ?? "UTC" })
  );
  const preferredHour = parseInt(pref.preferred_study_time.split(":")[0], 10);
  return userNow.getHours() === preferredHour;
}
```

### Schedule the CRON in Supabase Dashboard

Dashboard → Edge Functions → engagement-cron → Schedule:
```
0 * * * *    (every hour, on the hour)
```

---

# 8. Edge Function Environment Variables

Set in: **Supabase Dashboard → Settings → Edge Functions → Secrets**

```
OPENROUTER_API_KEY          OpenRouter API key (https://openrouter.ai)
OPENROUTER_MODEL            Model string, e.g. google/gemini-2.0-flash-001
SUPABASE_URL                https://<project-ref>.supabase.co
SUPABASE_ANON_KEY           Supabase public key
SUPABASE_SERVICE_ROLE_KEY   Supabase secret key — never in Flutter
FCM_PROJECT_ID              Firebase project ID (from Firebase Console)
FCM_SERVICE_ACCOUNT_JSON    Full Firebase service account JSON
```

---

# 9. Flutter File Structure — Data Layer

```
lib/
  core/
    constants/
      app_keys.dart                       # supabaseUrl, anonKey, googleServerClientId
    providers/
      supabase_providers.dart             # supabaseClientProvider
      storage_providers.dart              # localDataBaseProvider
    services/
      push/
        push_notification_service.dart    # FCM lifecycle + token saved to Supabase
      analytics_service.dart              # Firebase Analytics wrapper (analyticsService provider)
      crash_service.dart                  # Firebase Crashlytics wrapper (crashService provider)
    local/
      local_data_base.dart
      hive_local_data_base.dart
      hive_cache_keys.dart

  features/
    auth/
      data/
        datasources/
          auth_remote_data_source.dart
          auth_remote_data_source_impl.dart     # Supabase Auth + Google Sign-In
        models/
          user_model.dart                       # fromSupabaseUser()
        repositories/
          auth_repository_impl.dart             # calls clearUserData() on logout

    lessons/
      data/
        datasources/
          lesson_remote_data_source.dart
          lesson_remote_data_source_impl.dart   # invokes AI Edge Functions
          lesson_local_data_source.dart
          lesson_local_data_source_impl.dart    # Hive cache
        models/
          lesson_model.dart
          node_model.dart
          node_content_model.dart               # AI JSON contract
          daily_challenge_model.dart
          node_progress_model.dart

    profile/
      data/
        datasources/
          profile_remote_data_source.dart
          profile_remote_data_source_impl.dart  # Supabase profiles + user_progress
```

---

# 10. Edge Functions — Deploy

```sh
# Authenticate
supabase login

# Deploy individual function
supabase functions deploy generate-lesson --project-ref <project-ref>
supabase functions deploy generate-daily-challenge --project-ref <project-ref>
supabase functions deploy send-push --project-ref <project-ref>
supabase functions deploy engagement-cron --project-ref <project-ref>

# Set secrets
supabase secrets set OPENROUTER_API_KEY=<key> --project-ref <project-ref>
supabase secrets set OPENROUTER_MODEL=google/gemini-2.0-flash-001 --project-ref <project-ref>
supabase secrets set FCM_PROJECT_ID=<id> --project-ref <project-ref>
supabase secrets set FCM_SERVICE_ACCOUNT_JSON='<json>' --project-ref <project-ref>
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=<key> --project-ref <project-ref>
```

---

# 11. Service Access Rules

```dart
// ❌ FORBIDDEN — any external service called directly in a widget
Supabase.instance.client.from('profiles')...  // in widget → INVALID
FirebaseMessaging.instance.getToken()...      // in widget → INVALID

// ❌ FORBIDDEN — external service called directly in a provider
@riverpod
Future<Profile> myProfile(Ref ref) async {
  return Supabase.instance.client.from('profiles')...  // INVALID
}

// ✅ REQUIRED flow
// Widget → ref.watch(provider) → Notifier → Repository → DataSource → Supabase / FCM
```

---

# 🚨 Deploy Checklist

```
Database
[ ] All tables created in correct order (trigger depends on auth.users existing first)
[ ] handle_new_user trigger created and tested
[ ] RLS enabled on every table containing user data
[ ] All indexes created (section 4.11)
[ ] Policies tested — user cannot access another user's data

Edge Functions
[ ] generate-lesson: deployed + secrets configured
[ ] generate-daily-challenge: deployed + secrets configured
[ ] send-push: deployed with FCM_SERVICE_ACCOUNT_JSON (NOT legacy FCM_SERVER_KEY)
[ ] engagement-cron: deployed + CRON scheduled in Dashboard (0 * * * *)
[ ] OpenRouter rate limiting tested in generate-lesson

FCM
[ ] google-services.json placed in android/app/
[ ] GoogleService-Info.plist placed in ios/Runner/
[ ] Permission requested before calling getToken()
[ ] onTokenRefresh listener active after login
[ ] Token saved via upsert with onConflict: 'user_id,fcm_token'
[ ] PushNotificationService.initialize() called after successful login

Security
[ ] OPENROUTER_API_KEY absent from all Flutter files
[ ] FCM_SERVICE_ACCOUNT_JSON absent from all Flutter files
[ ] SUPABASE_SERVICE_ROLE_KEY absent from all Flutter files
[ ] AppKeys contains ONLY: supabaseUrl, supabaseAnonKey, googleServerClientId

Logout
[ ] signOut() calls both Supabase Auth signOut + Google SignOut
[ ] localDataBase.clearUserData() called on logout (clears Hive — preserves settings)
```