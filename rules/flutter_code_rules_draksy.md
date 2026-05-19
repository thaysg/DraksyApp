# Flutter Code Rules — Draksy (ENFORCED VERSION)

> These rules are **mandatory and restrictive**.
> Any violation makes the code **invalid**.

---

# 🚨 0. HARD FAIL RULES (CRITICAL — NON NEGOTIABLE)

## 📁 File & Widget Structure (ABSOLUTE RULE)

This is NOT a guideline.
This is a **compilation-level constraint**.

### ✅ REQUIRED

- Exactly **1 Dart file = 1 Widget class**
- Each widget MUST be in its own file
- Pages go in `pages/`
- Reusable widgets go in `widgets/`

### ❌ FORBIDDEN (ZERO TOLERANCE)

```dart
// ❌ Multiple widget classes in the same file
class MyPage extends StatelessWidget {}
class MyCard extends StatelessWidget {} // INVALID — move to widgets/my_card.dart
```

```dart
// ❌ Private builder methods
Widget _buildHeader() {}
Widget _buildCard() {}
Widget _buildList() {}
```

```dart
// ❌ Inline helper widget methods
Widget someHelper() {}
```

```dart
// ❌ Nested widget classes
class Parent extends StatelessWidget {
  class Child extends StatelessWidget {} // INVALID
}
```

### 🚫 IF THIS HAPPENS:

➡️ Code is INVALID
➡️ MUST be rewritten with one file per widget
➡️ DO NOT continue building on top of invalid structure

---

## 🧠 AI BEHAVIOR CONTROL RULE

Even if the UI has multiple sections (header, cards, lists, items):

👉 **KEEP EVERYTHING inside ONE widget class per file**

Do NOT try to "organize better" by extracting helpers inside the same file.

Widget extraction means **creating a new file in `widgets/`** — not a private method.

---

# 🚨 1. APPCOLORS — ABSOLUTE ENFORCEMENT

## This is the most violated rule in the codebase.

> `Colors.*` and raw `Color(0xFF...)` are **BANNED** everywhere.
> `AppColors` already covers every color needed. Use it.

---

## ❌ FORBIDDEN — Zero Tolerance

```dart
Colors.white
Colors.black
Colors.transparent
Colors.grey
Colors.red
Colors.amber       // ← currently violated in home_page.dart
Colors.orange      // ← currently violated in home_header.dart
Colors.green
Colors.blue
Colors.purple
Color(0xFFFFFFFF)
Color(0xFF000000)
Color(0x00000000)
```

---

## ✅ REQUIRED — AppColors Substitution Table

| Forbidden | Use Instead |
|---|---|
| `Colors.white` | `AppColors.surfaceLight` or `AppColors.textPrimaryDark` |
| `Colors.black` | `AppColors.backgroundDark` or `AppColors.textPrimaryLight` |
| `Colors.transparent` | `AppColors.transparent` |
| `Colors.grey` | `AppColors.textSecondary(context)` or `AppColors.textSecondaryLight` |
| `Colors.amber` | `AppColors.secondaryLight` _(Amber Gold — `0xFFFF8F00`)_ |
| `Colors.orange` | `AppColors.accent` _(Warm Coral — `0xFFFF5722`)_ or `AppColors.rpgOrange` |
| `Colors.red` | `AppColors.primaryAppColor` or `AppColors.error` or `AppColors.hp` |
| `Colors.green` | `AppColors.success` or `AppColors.green` |
| `Colors.blue` | `AppColors.mana` or `AppColors.info` |
| `Colors.purple` | `AppColors.purple` |
| `Colors.yellow` | `AppColors.gold` or `AppColors.secondaryDark` |
| `Colors.brown` | `AppColors.rpgBrown` |
| `Color(0xFF...)` | Define in `AppColors` or use the closest existing constant |

---

## ✅ Full AppColors Reference

### Theme-aware (require `BuildContext`) — use these in widgets:

```dart
AppColors.primary(context)              // primary color of current theme
AppColors.onPrimary(context)            // text/icon on primary color
AppColors.secondary(context)            // secondary color
AppColors.surface(context)              // surface / card background
AppColors.onSurface(context)            // text/icon on surface
AppColors.surfaceContainerHighest(context)
AppColors.background(context)           // = colorScheme.surface
AppColors.errorColor(context)
AppColors.outline(context)
AppColors.primaryContainer(context)
AppColors.onPrimaryContainer(context)
AppColors.primaryColor(context)
AppColors.scaffoldBackground(context)
AppColors.divider(context)
AppColors.hint(context)
AppColors.disabled(context)
AppColors.card(context)
AppColors.textPrimary(context)          // primary text, adapts light/dark
AppColors.textSecondary(context)        // secondary text, adapts light/dark
AppColors.xpBarBackground(context)
```

### Static constants (no context needed) — use for fixed colors:

```dart
// Primary palette
AppColors.primaryAppColor   // Crimson Red — #F52D5B
AppColors.primaryLight      // Soft Red — #EF5350
AppColors.primaryDark       // Rose — #EF9A9A
AppColors.primaryDeep       // Dark Red — #B71C1C

// Secondary
AppColors.secondaryLight    // Amber Gold — #FF8F00  ← use instead of Colors.amber
AppColors.secondaryDark     // Gold bright — #FFCC02

// Tertiary
AppColors.tertiaryLight     // Deep Teal — #00695C
AppColors.tertiaryDark      // Teal light — #4DB6AC

// Accent
AppColors.accent            // Warm Coral — #FF5722  ← use instead of Colors.orange (default)

// Backgrounds
AppColors.backgroundLight   // #FFFBFB
AppColors.backgroundDark    // #242A32
AppColors.surfaceLight      // #F9F0F0  ← use instead of Colors.white
AppColors.surfaceDark       // #2A2D3E
AppColors.scafoldBackgroungLight
AppColors.scafoldBackgroungDark

// Text
AppColors.textPrimaryLight
AppColors.textPrimaryDark   // ← use instead of Colors.white on dark surfaces
AppColors.textSecondaryLight
AppColors.textSecondaryDark

// Functional (fixed)
AppColors.success           // #00695C
AppColors.error             // #D32F2F
AppColors.warning           // #FF8F00
AppColors.info              // #1976D2
AppColors.successLight      // #90CAF9

// Game / RPG (fixed)
AppColors.rpgBrown          // #5D4037
AppColors.rpgOrange         // #E49834  ← use instead of Colors.orange (RPG context)
AppColors.gold              // #FFD700  ← use instead of Colors.yellow/amber (gold)
AppColors.silver            // #C0C0C0
AppColors.bronze            // #CD7F32
AppColors.hp                // #D32F2F
AppColors.mana              // #1976D2  ← use instead of Colors.blue
AppColors.purple            // #9575CD  ← use instead of Colors.purple
AppColors.green             // #7CB342  ← use instead of Colors.green

// Special
AppColors.transparent       // 0x00000000  ← use instead of Colors.transparent

// Gradients
AppColors.primaryGradient
AppColors.heroGradient
AppColors.xpBarGradient
AppColors.worldCardGradient
AppColors.homeUserGradient
AppColors.blueGradient
AppColors.darkGradient
AppColors.livesGradient
AppColors.premiumGradient

// Premium
AppColors.premiumNavy
AppColors.premiumPurple
```

---

## 🚫 VIOLATION EXAMPLES FOUND IN THE CODEBASE

These violations currently exist and must **never** be repeated:

```dart
// ❌ home_page.dart — line 38
iconColor: Colors.amber,
// ✅ Fix:
iconColor: AppColors.secondaryLight,

// ❌ home_header.dart — line 64
color: Colors.orange,
// ✅ Fix:
color: AppColors.accent,        // if decorative warm color
// or:
color: AppColors.rpgOrange,     // if RPG/game context
```

---

# 2. Architecture

## 2.1 Clean Architecture per Feature

```
lib/features/<feature>/
  presentation/
    pages/         # Screen widgets (StatelessWidget / ConsumerWidget)
    widgets/       # Feature-scoped reusable widgets
    providers/     # Riverpod providers (+ .g.dart generated files)
  data/
    datasources/   # Interfaces + implementations
    models/        # DTOs / data models
    repositories/  # Repository implementations
  domain/
    entities/      # Pure domain entities (no framework dependency)
    repositories/  # Repository interfaces
    usecases/      # Use cases (one action per file)
```

Features without data logic (e.g. `home_navigation`, simple `shop`) may use only `page/` and `widgets/` directly under the feature root.

## 2.2 Core Layer

```
lib/core/
  constants/     # AppConstants, AppRoutes, AppImages, AppIcons, AppBoxNames
  errors/        # Failures, Exceptions
  extensions/    # ContextExtension, SizedBoxExtensions, LocalizationExtension
  local/         # LocalDataBase (interface), HiveLocalDataBase (impl), HiveCacheKeys
  providers/     # storage_providers (SharedPreferences, LocalDataBase, HiveBox)
  responsive/    # AppResponsive, ResponsiveLayout, OrientationLayout
  router/        # app_router.dart + app_router.g.dart
  theme/         # AppColors, AppTextStyles, AppTheme, ThemeProvider, ThemeStorage
  widgets/       # Global reusable widgets
```

---

# 3. State Management — Riverpod

- **Required**: use `riverpod_annotation` with code generation.
- Annotate all providers with `@riverpod`.
- Always include `part '<file>.g.dart';` in every provider file.
- **Rule**: business logic NEVER lives inside widgets — always in providers/notifiers.
- Use `ConsumerWidget` when a widget needs to read a provider.
- Use `ConsumerStatefulWidget` only when you need `State` + `ref` together.
- `StateProvider` is allowed for simple UI state (e.g. `navigationIndexProvider`).
- Prefer generated `AsyncNotifier` / `Notifier` for complex state.

```dart
// ✅ CORRECT
@riverpod
class Auth extends _$Auth {
  @override
  Stream<User?> build() => ref.watch(authRepositoryProvider).userChanges;
}

// ❌ FORBIDDEN — manual provider without annotation
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(...);
```

---

# 4. Navigation — GoRouter

- All routes declared in `lib/core/router/app_router.dart`.
- Router provider is generated via `@riverpod` (`appRouterProvider`).
- Route names → `AppRoutes`, route paths → `AppPaths` (`lib/core/constants/app_routes.dart`).

```dart
// ✅ CORRECT
context.go(AppPaths.home);
context.pushNamed(AppRoutes.profile);

// ❌ FORBIDDEN
Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
```

---

# 5. Design System

## 5.1 Colors — See Section 1 above (AppColors)

All color rules are covered in Section 1. The summary:

```dart
// ✅ CORRECT
color: AppColors.primaryAppColor
color: AppColors.primary(context)
color: AppColors.textSecondary(context)
color: AppColors.transparent

// ❌ FORBIDDEN
color: Colors.white
color: Colors.black
color: Colors.transparent
color: Colors.amber
color: Colors.orange
color: Color(0xFFF52D5B)
```

## 5.2 Typography — AppTextStyles

**Never** define `TextStyle` inline. All styles use `GoogleFonts.nunito()`.

```dart
// ✅ CORRECT
Text('Title', style: AppTextStyles.h3(context))
Text('Body', style: AppTextStyles.bodyMedium(context))
Text('Custom', style: AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.w900))

// ❌ FORBIDDEN
Text('Title', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
```

### Available text styles:

| Style | Size | Weight | Notes |
|---|---|---|---|
| `h1(context)` | 32sp | 800 | Main headings |
| `h2(context)` | 28sp | 800 | |
| `h3(context)` | 24sp | 700 | |
| `h4(context)` | 20sp | 700 | |
| `bodyLarge(context)` | 16sp | 400 | |
| `bodyMedium(context)` | 14sp | 600 | |
| `bodySmall(context)` | 12sp | 400 | |
| `buttonLarge(context)` | 12sp | 700 | |
| `buttonMedium(context)` | 14sp | 700 | |
| `appBarTitle(context)` | 20sp | 800 | AppBar only |
| `titleMedium(context)` | 16sp | 700 | List tiles, cards |
| `error(context)` | — | — | Red text |
| `success(context)` | — | — | Teal text |
| `warning(context)` | — | — | Amber text |
| `primaryText(context)` | — | — | Primary-colored text |

## 5.3 Dimensions — ScreenUtil

Design size: `360×690`. Always use `.sp` for fonts, `.r`/`.w`/`.h` for dimensions.

```dart
// ✅ CORRECT
fontSize: 16.sp
height: 200.r
width: 48.w

// ❌ FORBIDDEN
fontSize: 16
height: 200
```

## 5.4 Spacing — SizedBoxExtensions

```dart
// ✅ CORRECT
8.heightBox      // SizedBox(height: 8)
16.widthBox      // SizedBox(width: 16)
24.squareBox     // SizedBox(height: 24, width: 24)
```

---

# 6. Global Widgets

**Before creating any widget, check `lib/core/widgets/`.**

| Widget | Use For |
|---|---|
| `CustomButton` | All buttons (elevated / outlined / text), with loading state + icon support |
| `CustomListTile` | List items with colored icon, title, subtitle, trailing |
| `CustomDecoratedBox` | Decorated containers with color/gradient/border/opacity |
| `CustomScroll` | Scroll with bounce physics |
| `XpBar` | XP progress bar with gradient |
| `HeartLivesIndicator` | Lives display (hearts) |
| `DecoratedIcon` | Icon with decorated background |
| `LoadingIndicator` | Loading spinner |
| `FadeInWidget` | Fade-in entrance animation |
| `ErrorRetryWidget` | Error state with retry button |

```dart
// ✅ CustomButton
CustomButton(
  text: 'Continue',
  onPressed: () {},
  isLoading: false,
  type: ButtonType.elevated,  // elevated | outlined | text
  icon: Icons.arrow_forward,
  height: 56,
)

// ✅ CustomListTile
CustomListTile(
  title: 'Notifications',
  subtitle: 'Enable daily reminders',
  icon: Icons.notifications_rounded,
  iconColor: AppColors.warning,
  onTap: () {},
)

// ✅ CustomDecoratedBox
CustomDecoratedBox(
  color: AppColors.primaryAppColor,
  opacity: 0.15,
  borderRadius: BorderRadius.circular(16),
  padding: const EdgeInsets.all(16),
  child: ...,
)
```

---

# 🚨 6.1 CRITICAL: WIDGET REUSE RULE

Before creating ANY new widget:

👉 Check `core/widgets/`

- If it exists → **USE IT**
- If it doesn't → create it in a **separate file** inside `widgets/`

---

# 🚨 6.2 FORBIDDEN PATTERNS (REINFORCED)

```dart
// ❌ Private builder methods — INVALID
class MyPage extends StatelessWidget {
  Widget _buildCard() { ... }
  Widget _buildHeader() { ... }
}

// ❌ Multiple classes in one file — INVALID
// my_page.dart
class MyPage extends StatelessWidget { ... }
class MyCard extends StatelessWidget { ... }  // must be in widgets/my_card.dart
```

```dart
// ✅ CORRECT structure
// pages/my_page.dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MyCard(),     // imported from widgets/my_card.dart
          const MyHeader(),   // imported from widgets/my_header.dart
        ],
      ),
    );
  }
}

// widgets/my_card.dart
class MyCard extends StatelessWidget { ... }

// widgets/my_header.dart
class MyHeader extends StatelessWidget { ... }
```

---

# 7. Theme

- Already configured via `AppTheme.lightTheme(context)` and `AppTheme.darkTheme(context)`.
- Uses `useMaterial3: true` — **never** disable.
- Theme mode controlled by `themeProvider` — never change `ThemeMode` directly.
- Access current brightness: `context.isDarkMode`.

---

# 8. Responsiveness

## 8.1 Breakpoints

| Device | Width Range |
|---|---|
| Mobile | `< 600px` |
| Tablet | `600px – 899px` |
| Desktop | `>= 900px` |

---

## 8.2 Responsive Helpers

```dart
// ✅ Via context extension (preferred in widgets)
context.isMobile
context.isTablet
context.isDesktop
context.screenWidth
context.screenHeight
context.horizontalPadding   // 32 on mobile/tablet, 64 on desktop
context.isPortrait
context.isLandscape
context.maxContentWidth      // 800 on desktop, 600 on tablet, infinity on mobile
context.gridColumns          // 1 (mobile portrait), 2 (landscape), 3 (tablet), 4 (desktop)

// ✅ Via static class (outside widgets or when context extension is not available)
AppResponsive.isMobile(context)
AppResponsive.isTablet(context)
AppResponsive.isDesktop(context)
AppResponsive.horizontalPadding(context)
AppResponsive.maxContentWidth(context)
AppResponsive.gridColumns(context)
```

---

## 8.3 Page Responsiveness Pattern (MANDATORY)

Every page MUST delegate its layout to three separate view widgets — one per device type.
This is the **only** accepted pattern for responsive pages. Do NOT use inline conditionals in the page itself.

### File structure

```
lib/features/<feature>/
  <feature>_page.dart          # Entry point — handles async state + dispatches to views
  views/
    <feature>_mobile_view.dart
    <feature>_tablet_view.dart
    <feature>_desktop_view.dart
  widgets/                     # Shared widgets used by all views
```

---

### Page-level ViewModel Pattern (REQUIRED when page has async data)

When a page depends on async data, the Page is the **single point** of `ref.watch` and async handling.
Data is collected into a typed `*ViewData` model and passed to views as a parameter.

**This is NOT optional.** Views must never do their own `ref.watch`. The compiler enforces this — if a widget requires a typed parameter, all 3 views will fail to compile if they miss it, preventing accidental omissions across devices.

```dart
// ✅ CORRECT — home_page.dart (with async data)
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewAsync = ref.watch(homeViewProvider);

    return Scaffold(
      body: SafeArea(
        child: homeViewAsync.when(
          data: (data) => ResponsiveLayoutBuilder(
            builder: (context, deviceType) => switch (deviceType) {
              DeviceType.mobile  => HomeMobileView(data: data),
              DeviceType.tablet  => HomeTabletView(data: data),
              DeviceType.desktop => HomeDesktopView(data: data),
            },
          ),
          loading: () => const LoadingIndicator(),
          error: (error, __) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(homeViewProvider),
          ),
        ),
      ),
    );
  }
}
```

```dart
// ✅ CORRECT — home_mobile_view.dart
// Views are ALWAYS StatelessWidget — never ConsumerWidget
// They receive ViewData and delegate data to child widgets
class HomeMobileView extends StatelessWidget {
  const HomeMobileView({required this.data, super.key});

  final HomeViewData data;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(userName: data.userName, streak: data.streak),
            20.heightBox,
            StatCardsSection(xp: data.xp, level: data.level, lives: data.lives),
            20.heightBox,
            // ...
            100.heightBox,
          ],
        ),
      );
}
```

```dart
// ✅ CORRECT — home_view_data.dart
// All ViewData classes (DTOs) for the same screen may live in one file.
// The "1 file = 1 class" rule applies to WIDGET classes only — not data models.
class HomeViewData extends Equatable {
  const HomeViewData({
    required this.userName,
    required this.xp,
    // ...
  });
  // ...
}

class HomeLessonData extends Equatable { ... }
class HomeDailyChallengeData extends Equatable { ... }
```

---

### Page without async data (no ViewData needed)

When a page has no async data (pure layout / navigation shell), views use `const` constructors and the page dispatches directly:

```dart
// ✅ CORRECT — shop_page.dart (no async data)
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ResponsiveLayoutBuilder(
            builder: (context, deviceType) => switch (deviceType) {
              DeviceType.mobile  => const ShopMobileView(),
              DeviceType.tablet  => const ShopTabletView(),
              DeviceType.desktop => const ShopDesktopView(),
            },
          ),
        ),
      );
}
```

---

### StatefulWidget + State — not a violation of the 1-class rule

A `StatefulWidget` always produces two classes in the same file: the widget itself and its private `_State` class. This is the standard Flutter pattern and is **NOT a violation**:

```dart
// ✅ CORRECT — 1 file, 1 widget, its required private State
class LessonPathCurrentNode extends StatefulWidget {
  // ...
}

class _LessonPathCurrentNodeState extends State<LessonPathCurrentNode> {
  // ...
}
```

The rule "1 file = 1 widget class" means one **public** widget. A private `_*State` class is its implementation detail, not a second widget.

```dart
// ❌ FORBIDDEN — two distinct public widgets in one file
class LessonPathCurrentNode extends StatefulWidget { ... }
class LessonPathNode extends StatelessWidget { ... }  // must be its own file
```

---

## 8.4 View Layout Conventions (Home & Shop reference)

### Mobile view

- `CustomScroll` as root — already provides horizontal + vertical padding
- Vertical `Column` with all sections stacked
- Horizontal `ListView` for scrollable card rows (e.g. lesson cards)
- Bottom spacing of at least `80–100.heightBox` to clear the bottom nav bar

```dart
// ✅ CORRECT — home_mobile_view.dart
class HomeMobileView extends ConsumerWidget {
  const HomeMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            20.heightBox,
            // ... sections
            100.heightBox, // bottom nav clearance
          ],
        ),
      );
}
```

### Tablet view

- `CustomScroll` as root
- Two-column `Row` for sections that benefit from side-by-side layout (e.g. daily challenge + lessons)
- Use `Expanded` with `flex` ratios (e.g. `flex: 3` / `flex: 2`)
- Spacing between columns: `32.widthBox`

```dart
// ✅ CORRECT — home_tablet_view.dart
CustomScroll(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const HomeHeader(),
      24.heightBox,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Column(children: [...])),
          32.widthBox,
          Expanded(flex: 2, child: Column(children: [...])),
        ],
      ),
      100.heightBox,
    ],
  ),
)
```

### Desktop view

- `CustomScroll` as root
- `Center` + `ConstrainedBox` with `BoxConstraints(maxWidth: AppResponsive.maxContentWidth(context))` to limit content width to `800px`
- Two-column `Row` layout (similar to tablet but wider ratios and larger spacing)
- Spacing between columns: `40.widthBox` or more

```dart
// ✅ CORRECT — home_desktop_view.dart
CustomScroll(
  child: Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: AppResponsive.maxContentWidth(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          32.heightBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: Column(children: [...])),
              40.widthBox,
              Expanded(flex: 1, child: Column(children: [...])),
            ],
          ),
          100.heightBox,
        ],
      ),
    ),
  ),
)
```

### Desktop with Sidebar (Shop pattern)

When a feature has a sidebar on desktop, the `CustomScroll` wraps a top-level `Row` — sidebar on the left, main content on the right inside an `Expanded`.

```dart
// ✅ CORRECT — shop_desktop_view.dart
CustomScroll(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const ShopSidebar(),
      48.widthBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShopHeader(),
            48.heightBox,
            // ... sections
            100.heightBox,
          ],
        ),
      ),
    ],
  ),
)
```

---

## 🚨 8.5 CRITICAL: CustomScroll Child Rule

`CustomScroll` internally uses `SingleChildScrollView` with `padding` already applied:

```dart
// CustomScroll internals (DO NOT repeat this padding)
SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  padding: EdgeInsets.symmetric(
    horizontal: context.horizontalPadding,  // 32 mobile/tablet | 64 desktop
    vertical: 20,
  ),
  child: child,
)
```

### ❌ FORBIDDEN — Double padding (wrapping child in Padding)

```dart
// ❌ INVALID — padding is already handled by CustomScroll
CustomScroll(
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(...),
  ),
)
```

### ✅ CORRECT — Pass content directly

```dart
// ✅ CORRECT — CustomScroll handles all padding
CustomScroll(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [...],
  ),
)
```

> **Rule**: The `child` of `CustomScroll` is NEVER a `Padding` widget.
> The padding (horizontal + vertical) is already baked into `CustomScroll`.
> Adding extra `Padding` creates double-padding and wrong layout — it must be corrected every time.

---

## 8.6 Spacing Between Sections per Device

| Section gap | Mobile | Tablet | Desktop |
|---|---|---|---|
| Header → content | `20` | `24` | `32` |
| Between sections | `20–32` | `32–40` | `40–48` |
| Bottom nav clearance | `80–100` | `80–100` | `100` |
| Column gap (sidebar/row) | — | `32` | `40–48` |

---

# 9. Localization (i18n)

```dart
// ✅ CORRECT
context.l10n.dailyChallenge
context.l10n.unitLesson(3, 2)
context.l10n.continueLearning

// ❌ FORBIDDEN
'Daily Challenge'    // hardcoded string
'Continue Learning'
```

All new user-visible strings must be added to `lib/l10n/app_en.arb` and translated in `app_pt.arb`.

---

# 10. Constants

**Never** use string literals for routes, image paths, icon paths, or game values.

| Class | Contains |
|---|---|
| `AppConstants` | Game constants (lives, XP, levels, lessons, currency) |
| `AppRoutes` / `AppPaths` | Route names and paths |
| `AppImages` | Asset image paths |
| `AppIcons` | Asset icon paths |

---

# 11. Errors & Exceptions

- Domain exceptions → `lib/core/errors/exceptions.dart`
- Failures (operation results) → `lib/core/errors/failures.dart`
- Repositories use `StrautilsTryThis` from `strawti_utils`:

```dart
FStrautilsResponse<User> signInWithGoogle() async => tryThis(
  () async {
    final userModel = await _remoteDataSource.signInWithGoogle();
    return StrautilsResponse.success(userModel);
  },
  onCatch: (error) {
    if (error is AuthException) {
      return StrautilsResponse.error(error.message, error: error);
    }
    return StrautilsResponse.error(error.toString(), error: error);
  },
  tryAgain: signInWithGoogle,
  action: 'sign in with Google',
);
```

---

# 12. Dependency Injection

- **Primary**: Riverpod (generated). Always use for new code.
- **Legacy**: GetIt (`getIt` in `injection_container.dart`) — kept for compatibility only. Do NOT add new dependencies via GetIt.

---

# 13. Hive — Local Storage

Hive is the **required** local persistence solution for structured offline data (lesson progress, daily challenge state, cached user data, settings).
`SharedPreferences` is kept only for theme mode. All other local persistence → **Hive**, accessed exclusively through the `LocalDataBase` abstraction.

---

## 13.1 Architecture Overview

The Hive integration uses a **three-layer abstraction**:

```
LocalDataBase (abstract interface)          lib/core/local/local_data_base.dart
  └── HiveLocalDataBase (implementation)   lib/core/local/hive_local_data_base.dart
        └── opens boxes lazily on demand

HiveCacheKeys                              lib/core/local/hive_cache_keys.dart
  └── composite key builder (boxName__innerKey)

AppBoxNames                                lib/core/constants/app_box_names.dart
  └── box name constants — never use raw strings
```

**DataSources depend on `LocalDataBase`, never on `Box<dynamic>` directly.**
Boxes are opened lazily inside `HiveLocalDataBase` — they are **not** pre-opened in `main()` and **not** injected via `ProviderScope` overrides.

---

## 13.2 Box Name Constants — `AppBoxNames`

**Never** use raw strings to open or reference boxes. Always use `AppBoxNames`.

```dart
// lib/core/constants/app_box_names.dart
abstract class AppBoxNames {
  AppBoxNames._();

  static const String user             = 'user_box';
  static const String lessonProgress   = 'lesson_progress_box';
  static const String dailyChallenge   = 'daily_challenge_box';
  static const String settings         = 'settings_box';
}
```

To add a new box: add a constant here, register it in `HiveCacheKeys.userScopedBoxes` if it stores user data, and add a key-builder helper in `HiveCacheKeys`.

---

## 13.3 Composite Key System — `HiveCacheKeys`

Every Hive entry is addressed by a **composite key** with format `boxName__innerKey`.
The `__` double-underscore separator is defined in `HiveCacheKeys.separator`.

```dart
// lib/core/local/hive_cache_keys.dart
class HiveCacheKeys {
  HiveCacheKeys._();

  static const String separator = '__';

  // Box name aliases (maps to AppBoxNames for consistency)
  static const String userBox           = AppBoxNames.user;
  static const String lessonProgressBox = AppBoxNames.lessonProgress;
  static const String dailyChallengeBox = AppBoxNames.dailyChallenge;
  static const String settingsBox       = AppBoxNames.settings;

  // Composite key builders — always use these, never build keys manually
  static String lessonProgressKey(String unitId, String nodeId) =>
      '$lessonProgressBox$separator${unitId}_$nodeId';

  // User-scoped boxes — cleared entirely on logout
  static const Set<String> userScopedBoxes = {
    userBox,
    lessonProgressBox,
    dailyChallengeBox,
    // ← settingsBox intentionally excluded — device-level preference
  };
}
```

**Rules:**
- Always use a static helper (e.g. `HiveCacheKeys.lessonProgressKey(...)`) — never build composite keys manually with string interpolation.
- `settingsBox` is **not** user-scoped — do NOT add it to `userScopedBoxes`.
- Every new box that stores user data must be added to `userScopedBoxes`.

---

## 13.4 `LocalDataBase` Interface

The abstract contract used by all datasources. Hive is **never** mentioned at this level.

```dart
// lib/core/local/local_data_base.dart
abstract class LocalDataBase {
  Future<void> write(String key, Object? value);
  Future<T?> read<T>(String key);
  Future<void> delete(String key);
  Future<bool> exists(String key);
  Future<void> clear();                        // clears ALL opened boxes
  Future<List<T>> readAll<T>(String boxName);  // reads all values of type T from a box
  Future<void> clearUserData();                // clears only userScopedBoxes
}
```

---

## 13.5 `HiveLocalDataBase` — Implementation

`HiveLocalDataBase` is the **only** class that ever calls `Hive.*` APIs. It manages box lifecycle internally via a lazy in-memory cache (`_openedBoxes`).

```dart
// lib/core/local/hive_local_data_base.dart
class HiveLocalDataBase implements LocalDataBase {
  final Map<String, Box<dynamic>> _openedBoxes = {};

  String _extractBoxName(String key) => key.split(HiveCacheKeys.separator).first;
  String _extractInnerKey(String key) {
    final parts = key.split(HiveCacheKeys.separator);
    return parts.length > 1 ? parts[1] : key;
  }

  Future<Box<dynamic>> _openBoxIfNeeded(String key) async {
    final boxName = _extractBoxName(key);
    if (_openedBoxes.containsKey(boxName)) return _openedBoxes[boxName]!;
    final box = await Hive.openBox<dynamic>(boxName);
    _openedBoxes[boxName] = box;
    return box;
  }

  @override
  Future<void> write(String key, Object? value) async {
    final box = await _openBoxIfNeeded(key);
    await box.put(_extractInnerKey(key), value);
  }

  @override
  Future<T?> read<T>(String key) async {
    final box = await _openBoxIfNeeded(key);
    final value = box.get(_extractInnerKey(key));
    if (value == null) return null;
    return _normalizeForRead(value) as T?;
  }

  @override
  Future<void> delete(String key) async {
    final box = await _openBoxIfNeeded(key);
    await box.delete(_extractInnerKey(key));
  }

  @override
  Future<bool> exists(String key) async {
    final box = await _openBoxIfNeeded(key);
    return box.containsKey(_extractInnerKey(key));
  }

  @override
  Future<void> clear() async {
    for (final box in _openedBoxes.values) await box.clear();
    _openedBoxes.clear();
  }

  @override
  Future<List<T>> readAll<T>(String boxName) async {
    final box = _openedBoxes[boxName] ?? await Hive.openBox<dynamic>(boxName);
    _openedBoxes[boxName] = box;
    return box.values.whereType<T>().toList();
  }

  @override
  Future<void> clearUserData() async {
    for (final boxName in HiveCacheKeys.userScopedBoxes) {
      try {
        final box = _openedBoxes.remove(boxName)
            ?? await Hive.openBox<dynamic>(boxName);
        await box.clear();
        await box.close();
      } catch (_) {}
    }
  }

  // Normalizes nested Maps/Lists to string-keyed structures after read
  Object? _normalizeForRead(Object? value) {
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), _normalizeForRead(v)));
    }
    if (value is List) return value.map(_normalizeForRead).toList();
    return value;
  }
}
```

---

## 13.6 Riverpod Providers — `storage_providers.dart`

```dart
// lib/core/providers/storage_providers.dart

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('SharedPreferences must be overridden in ProviderScope');
}

/// Primary provider for local storage — use this in all datasources.
/// No ProviderScope override needed — HiveLocalDataBase opens boxes lazily.
@riverpod
LocalDataBase localDataBase(Ref ref) => HiveLocalDataBase();

/// Kept for rare cases where direct Box access is needed.
/// If used, the box must be pre-opened in main() and overridden in ProviderScope.
@riverpod
Box<dynamic> hiveBox(Ref ref, String boxName) {
  throw UnimplementedError(
    'HiveBox "$boxName" must be overridden in ProviderScope.',
  );
}
```

```dart
// ✅ CORRECT — datasource provider consuming LocalDataBase
@riverpod
LessonLocalDataSource lessonLocalDataSource(Ref ref) {
  final db = ref.watch(localDataBaseProvider);
  return LessonLocalDataSourceImpl(db);
}

// ❌ FORBIDDEN — injecting Box<dynamic> directly into a datasource
@riverpod
LessonLocalDataSource lessonLocalDataSource(Ref ref) {
  final box = ref.watch(hiveBoxProvider(AppBoxNames.lessonProgress));
  return LessonLocalDataSourceImpl(box);
}
```

---

## 13.7 Initialization — `main.dart`

Only `Hive.initFlutter()` and TypeAdapter registration happen in `main()`.
**Boxes are NOT pre-opened. No `hiveBoxProvider` overrides in `ProviderScope`.**

```dart
// ✅ REQUIRED ORDER in main()
await Hive.initFlutter();
_registerHiveAdapters();   // register all TypeAdapters before any box operation

runApp(
  ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      // ← NO hiveBoxProvider overrides — boxes open lazily via HiveLocalDataBase
    ],
    child: ...,
  ),
);

// ─── Register TypeAdapters here ───────────────────────────────────────────
void _registerHiveAdapters() {
  // Hive.registerAdapter(LessonProgressModelAdapter());  // TypeId 0
}
```

`_registerHiveAdapters()` is a dedicated top-level function in `main.dart`. All `Hive.registerAdapter(...)` calls live here. Keep TypeId assignments documented in comments next to each registration.

---

## 13.8 TypeAdapter Models — `@HiveType` / `@HiveField`

Any **custom type** stored in a box must have a `TypeAdapter`, generated via `hive_generator`.

```dart
// features/<feature>/data/models/<name>_model.dart

import 'package:hive/hive.dart';

part '<name>_model.g.dart';

@HiveType(typeId: 0)   // ← TypeId must be globally unique — see registry in main.dart
class LessonProgressModel extends HiveObject {
  LessonProgressModel({
    required this.unitId,
    required this.nodeId,
    required this.isCompleted,
    required this.xpEarned,
    this.completedAt,
  });

  @HiveField(0)
  String unitId;

  @HiveField(1)
  String nodeId;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  int xpEarned;

  @HiveField(4)
  String? completedAt;   // ISO-8601 timestamp
}
```

### TypeId Registry (global — keep updated in `main.dart` comments)

| TypeId | Model |
|---|---|
| 0 | `LessonProgressModel` |

> **Rule**: TypeIds are permanent. Never reuse a TypeId once released to production, even if the model is deleted.

### Regenerating adapters

```sh
dart run build_runner build --delete-conflicting-outputs
```

---

## 13.9 Local DataSource Pattern

Every Hive-backed feature follows Clean Architecture. DataSources receive `LocalDataBase` — **never** `Box<dynamic>`.

```
features/<feature>/
  data/
    datasources/
      <feature>_local_data_source.dart       # abstract interface (no Hive import)
      <feature>_local_data_source_impl.dart  # uses LocalDataBase + HiveCacheKeys
    models/
      <feature>_model.dart                   # @HiveType model + .g.dart
    providers/
      <feature>_local_providers.dart         # @riverpod datasource provider
```

**Interface** (no Hive import — pure contract):

```dart
abstract class LessonLocalDataSource {
  Future<LessonProgressModel?> getProgress({
    required String unitId,
    required String nodeId,
  });
  Future<void> saveProgress(LessonProgressModel model);
  Future<List<LessonProgressModel>> getAllProgress();
  Future<void> clearAll();
}
```

**Implementation** (uses `LocalDataBase` + `HiveCacheKeys` — no direct Hive access):

```dart
class LessonLocalDataSourceImpl implements LessonLocalDataSource {
  const LessonLocalDataSourceImpl(this._localDb);
  final LocalDataBase _localDb;

  @override
  Future<LessonProgressModel?> getProgress({
    required String unitId,
    required String nodeId,
  }) async {
    final key = HiveCacheKeys.lessonProgressKey(unitId, nodeId);
    return _localDb.read<LessonProgressModel>(key);
  }

  @override
  Future<void> saveProgress(LessonProgressModel model) async {
    final key = HiveCacheKeys.lessonProgressKey(model.unitId, model.nodeId);
    await _localDb.write(key, model);
  }

  @override
  Future<List<LessonProgressModel>> getAllProgress() =>
      _localDb.readAll<LessonProgressModel>(HiveCacheKeys.lessonProgressBox);

  @override
  Future<void> clearAll() => _localDb.clearUserData();
}
```

**Provider** (wires `LocalDataBase` → impl via Riverpod):

```dart
@riverpod
LessonLocalDataSource lessonLocalDataSource(Ref ref) {
  final db = ref.watch(localDataBaseProvider);
  return LessonLocalDataSourceImpl(db);
}
```

---

## 13.10 Simple Key-Value Storage (no TypeAdapter)

For primitive values (`String`, `int`, `bool`) a TypeAdapter is NOT needed.
Use `LocalDataBase` directly with composite keys from `HiveCacheKeys`.

```dart
// ✅ For primitives only — no @HiveType needed
class SettingsStorage {
  const SettingsStorage(this._localDb);
  final LocalDataBase _localDb;

  static const _keyLanguage =
      '${HiveCacheKeys.settingsBox}${HiveCacheKeys.separator}selected_language';

  Future<String?> get selectedLanguage => _localDb.read<String>(_keyLanguage);
  Future<void> saveLanguage(String code) => _localDb.write(_keyLanguage, code);
}
```

---

## 13.11 Logout / User Switch — Clear User Data

On logout, call `clearUserData()` on `LocalDataBase`. This clears all boxes listed in `HiveCacheKeys.userScopedBoxes` and preserves `settings_box`.

```dart
// ✅ In AuthRepositoryImpl.signOut()
await ref.read(localDataBaseProvider).clearUserData();
// settings_box is NOT in userScopedBoxes — it is preserved on logout
```

> **Rule**: Never call `clear()` on logout (that clears everything, including settings). Always use `clearUserData()`.

---

## 🚨 13.12 FORBIDDEN — Hive Anti-Patterns

```dart
// ❌ Raw string box name anywhere in the codebase
Hive.box('lesson_progress_box')                // use AppBoxNames

// ❌ Opening a box outside of HiveLocalDataBase
await Hive.openBox(...)                        // handled lazily internally

// ❌ Calling Hive.box() directly in widgets, providers, or datasources
final box = Hive.box<dynamic>('user_box')      // use localDataBaseProvider

// ❌ Injecting Box<dynamic> into a datasource
LessonLocalDataSourceImpl(box)                 // inject LocalDataBase instead

// ❌ Building composite keys manually
'lesson_progress_box__${unitId}_$nodeId'       // use HiveCacheKeys.lessonProgressKey(...)

// ❌ Storing complex nested Maps instead of a HiveObject
await _localDb.write('key', {'a': 1, 'b': {'c': 2}})  // create a @HiveType model

// ❌ Reusing or reassigning a TypeId
@HiveType(typeId: 0)   // 0 is already taken → CONFLICT
class AnotherModel ...

// ❌ Pre-opening boxes in main() and overriding hiveBoxProvider (not needed anymore)
hiveBoxProvider(AppBoxNames.lessonProgress).overrideWithValue(lessonProgressBox)

// ❌ withOpacity() on any color
AppColors.primaryAppColor.withOpacity(0.5)    // use .withValues(alpha: 0.5)
```

---

# 14. Widget Patterns

## 14.1 Widget Type Selection

```dart
// No local state, no providers → StatelessWidget
class MyWidget extends StatelessWidget { ... }

// Needs providers → ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) { ... }
}

// Local state + providers → ConsumerStatefulWidget
class MyWidget extends ConsumerStatefulWidget { ... }
```

## 14.2 `const` Constructors

Always declare `const` when the widget has no non-const properties:

```dart
// ✅ CORRECT
const MyWidget({super.key});

// ❌ FORBIDDEN
MyWidget({super.key});   // missing const
```

## 14.3 File & Class Naming

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Page widgets: `*Page` suffix (e.g. `HomePage`, `ProfilePage`)
- Reusable widgets: descriptive name or `*Widget` suffix (e.g. `BottomBarWidget`, `DailyChallengeCard`)
- Providers: `camelCaseProvider` / `camelCaseNotifier` (generated)

## 14.4 Import Order

1. `dart:*`
2. `package:flutter/*`
3. External packages (`package:riverpod_annotation/...`, etc.)
4. Internal imports with relative paths (`../../core/...`)

## 14.5 Constraints — `ConstrainedBox` over `Container`

Whenever the **only** purpose of a widget is to apply size constraints, use `ConstrainedBox` — **never** `Container` with only a `constraints` property.

```dart
// ✅ CORRECT
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 800),
  child: MyWidget(),
)

// ❌ FORBIDDEN — Container used only for constraints
Container(
  constraints: const BoxConstraints(maxWidth: 800),
  child: MyWidget(),
)
```

> **Rule**: `Container` is only allowed when it also carries decoration, color, padding, margin, or alignment alongside `constraints`. If `constraints` is the **only** argument besides `child`, replace `Container` with `ConstrainedBox`.

---

# 15. External Services — Firebase, Supabase and OpenRouter

## 15.1 Firebase — FCM only

Firebase is kept **exclusively for push notifications** (FCM).
There is no Firestore, Firebase Auth, Remote Config, or any other Firebase service in the project.

```
✅ KEPT     firebase_core, firebase_messaging, firebase_options.dart
❌ REMOVED  Firebase Auth, Firestore, database_helper.dart
```

- `firebase_options.dart` — do NOT edit manually
- Firebase is initialized in `main()` before `Supabase.initialize()`
- All push logic lives in `lib/core/services/push_notification_service.dart`
- `PushNotificationService.initialize()` is called after a successful login

## 15.2 Supabase — Auth, Database and Edge Functions

Supabase is the project's primary backend.

- Auth (Google OAuth), database, and Edge Functions → Supabase
- Client accessed via `supabaseClientProvider` (Riverpod)
- **Never** call `Supabase.instance.client` directly in widgets or providers — only in datasources
- Public keys in `AppKeys` (`supabaseUrl`, `supabaseAnonKey`)
- `SERVICE_ROLE` key never goes into Flutter — only in Edge Functions

## 15.3 OpenRouter — via Edge Function

The OpenRouter API is called **exclusively** by Supabase Edge Functions.
`OPENROUTER_API_KEY` is never present in the Flutter app.

```dart
// ✅ CORRECT — Flutter invokes the Edge Function
await Supabase.instance.client.functions.invoke('generate-lesson', body: {...});

// ❌ FORBIDDEN — calling OpenRouter directly from Flutter
await http.post(Uri.parse('https://openrouter.ai/api/v1/...'));`
```

> See `backend_architecture_rules.md` for the complete implementation of all services.

---

# 16. Bottom Navigation

- Navigation index controlled by `navigationIndexProvider` (StateProvider).
- FAB center button = tab index 2 (Map) — sets `navigationIndexProvider` to 2.
- Index offset logic (skipping index 2 for side tabs) lives in `HomeNavigation`.
- Custom bottom bar is in `lib/core/widgets/bottom_bar/` — do not replace with Flutter's native `BottomNavigationBar`.

---

## 🚨 VALIDATION GATE (MANDATORY)

Before outputting any code, you MUST validate ALL rules:

If ANY of the following is violated, you MUST STOP and FIX before continuing:

- More than 1 **public widget class** in a file → INVALID (a private `_*State` class alongside its `StatefulWidget` is the only exception)
- Any method starting with `_build` → INVALID
- Any use of `DecoratedBox` instead of `CustomDecoratedBox` → INVALID
- Missing required files → INVALID
- `CustomScroll` child is a `Padding` widget → INVALID (double padding — remove it)
- `Container` used only for constraints → INVALID (use `ConstrainedBox` instead)
- View widget is `ConsumerWidget` or does `ref.watch` → INVALID (data comes from Page via ViewData)
- Page with async data does not use a `*ViewData` model → INVALID
- DataSource receives `Box<dynamic>` directly → INVALID (must receive `LocalDataBase`)
- Composite key built manually as a string → INVALID (use `HiveCacheKeys.*` helpers)
- `Hive.openBox()` called outside of `HiveLocalDataBase` → INVALID
- `Hive.box()` called outside of `HiveLocalDataBase` → INVALID

You are NOT allowed to output partial or invalid code.

If necessary, rewrite EVERYTHING until it passes 100%.

---

# 🔥 FINAL CHECKLIST

Before submitting any code, verify:

```
1.  ONE FILE = ONE PUBLIC WIDGET CLASS
    (StatefulWidget + private _State in same file = OK)
2.  NO _build* METHODS
3.  NO Colors.* — use AppColors ALWAYS
4.  NO TextStyle(...) — use AppTextStyles ALWAYS
5.  NO Color(0xFF...) inline
6.  NO hardcoded user-visible strings — use context.l10n
7.  NO Navigator.push — use GoRouter (context.go / context.pushNamed)
8.  NO GetIt for new dependencies — use Riverpod
9.  NO withOpacity() — use withValues(alpha: ...)
10. ALL font sizes use .sp, ALL dimensions use .r/.w/.h
11. CHECK core/widgets/ before creating any new widget
12. ALL new routes declared in app_router.dart + AppRoutes + AppPaths
13. CustomScroll child is NEVER a Padding widget — padding is already inside CustomScroll
14. EVERY page with responsive layout has views/ folder with *MobileView, *TabletView, *DesktopView
15. NO Container with only `constraints` — use ConstrainedBox instead
16. ALL Hive box names via AppBoxNames — never raw strings
17. ALL composite cache keys via HiveCacheKeys helpers — never built manually
18. ALL local datasources receive LocalDataBase (via localDataBaseProvider) — never Box<dynamic>
19. Boxes open lazily inside HiveLocalDataBase — NEVER call Hive.openBox() or Hive.box() elsewhere
20. NO hiveBoxProvider overrides in ProviderScope for new datasources — use localDataBaseProvider
21. ALL custom Hive types use @HiveType / @HiveField — never raw Map<String, dynamic>
22. TypeIds are globally unique and permanent — document every new one in main.dart _registerHiveAdapters()
23. On logout: call localDataBase.clearUserData() — NOT box.clear() / localDataBase.clear()
24. settingsBox is NEVER cleared on logout — it is excluded from HiveCacheKeys.userScopedBoxes
25. Views are ALWAYS StatelessWidget — never ConsumerWidget
26. ref.watch lives only in Page (or in self-contained widgets with no view data needed)
27. Pages with async data collect all state into a *ViewData model before passing to views
28. *ViewData and related DTO classes for the same screen may share one file (not widget classes)
29. NO Supabase.instance.client calls in widgets or providers — only in datasources
30. NO FirebaseMessaging calls outside of PushNotificationService
31. NO direct OpenRouter API calls from Flutter — always via Supabase Edge Function
32. NO secret keys in Flutter (OPENROUTER_API_KEY, SERVICE_ROLE, FCM_SERVICE_ACCOUNT_JSON)
33. AppKeys contains ONLY public keys (supabaseUrl, supabaseAnonKey, googleServerClientId)
34. Firebase is ONLY for FCM — no Firestore, no Firebase Auth, no other Firebase service
```