# Rules — `lib/core/router/`

GoRouter configuration. Single source of truth for all app routes.

---

## Files

| File | Purpose |
|---|---|
| `app_router.dart` | Route declarations + `@riverpod appRouterProvider` |
| `app_router.g.dart` | Generated — do **not** edit manually |

---

## Rules

### All routes must be declared here
- Every new screen needs a route added to `app_router.dart`.
- Route **names** → `AppRoutes` in `lib/core/constants/app_routes.dart`.
- Route **paths** → `AppPaths` in `lib/core/constants/app_routes.dart`.
- Never hardcode path strings anywhere else in the codebase.

### Router provider
- The GoRouter instance is provided via `@riverpod appRouterProvider`.
- Consumed in `app.dart` as `MaterialApp.router(routerConfig: ref.watch(appRouterProvider))`.

### Navigation — REQUIRED
```dart
// ✅ Correct
context.go(AppPaths.home)
context.pushNamed(AppRoutes.profile)
context.pop()
```

### Navigation — FORBIDDEN
```dart
// ❌ FORBIDDEN
Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))
Navigator.pushReplacement(...)
Navigator.pop(context)
```

### Redirect logic
- Auth redirect lives in the router (not in individual pages).
- Checks auth state from `authProvider` to decide where to redirect unauthenticated users.
