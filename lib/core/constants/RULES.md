# Rules — `lib/core/constants/`

All app-wide constant values. Never use raw literals anywhere else.

---

## Files

| File | Class | Contains |
|---|---|---|
| `app_constants.dart` | `AppConstants` | Game constants (lives, XP, levels, lessons, currency) |
| `app_routes.dart` | `AppRoutes` / `AppPaths` | Route names and paths |
| `app_images.dart` | `AppImages` | Asset image paths |
| `app_icons.dart` | `AppIcons` | Asset icon paths |
| `app_box_names.dart` | `AppBoxNames` | Hive box name strings |
| `app_keys.dart` | `AppKeys` | Misc string keys |

---

## Rules

### FORBIDDEN — raw string literals for:
```dart
// ❌ Routes
context.go('/home')
Navigator.pushNamed(context, '/profile')

// ❌ Image paths
Image.asset('assets/images/logo.png')

// ❌ Hive box names
Hive.box('lesson_progress_box')
await Hive.openBox('user_box')

// ❌ Game values
if (lives == 5)     // use AppConstants.maxLives
```

### REQUIRED substitutions:
```dart
// ✅ Routes
context.go(AppPaths.home)
context.pushNamed(AppRoutes.profile)

// ✅ Images
Image.asset(AppImages.logo)

// ✅ Hive boxes
Hive.box(AppBoxNames.lessonProgress)
await Hive.openBox(AppBoxNames.user)

// ✅ Game values
if (lives == AppConstants.maxLives)
```

---

## `AppBoxNames` — Hive Box Registry

```dart
abstract class AppBoxNames {
  static const String user             = 'user_box';
  static const String lessonProgress   = 'lesson_progress_box';
  static const String dailyChallenge   = 'daily_challenge_box';
  static const String settings         = 'settings_box';
}
```

- To add a new box: add a constant here, open it in `main.dart`, and override it in `ProviderScope`.
- Never open a box that doesn't have a constant here.

---

## `AppRoutes` / `AppPaths` — Route Registry

- `AppRoutes` → named route identifiers (used with `context.pushNamed`).
- `AppPaths` → path strings (used with `context.go`).
- Every route declaration in `app_router.dart` must have a matching constant in both classes.
