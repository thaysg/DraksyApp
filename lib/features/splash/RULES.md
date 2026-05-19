# Rules — `lib/features/splash/`

Splash screen. Decides whether to show intro, auth, or home.

---

## Structure

```
splash/
  presentation/
    pages/
      splash_page.dart                     # Full splash — animation + routing logic
    providers/
      splash_provider.dart / .g.dart       # @riverpod splashProvider
```

---

## Rules

- `SplashPage` is a `ConsumerWidget` (or `ConsumerStatefulWidget` if animation state is needed).
- Routing decision: watch auth state → navigate to `AppPaths.intro`, `AppPaths.auth`, or `AppPaths.home`.
- Navigation via GoRouter — `context.go(...)`. **FORBIDDEN**: `Navigator.push`.
- No responsive views needed for splash (single layout is acceptable).
- All colors → `AppColors`.
- All sizes → `.sp` / `.r` / `.w` / `.h`.
- If animation uses `StatefulWidget` + `_State`, that is valid — it is one public widget.
