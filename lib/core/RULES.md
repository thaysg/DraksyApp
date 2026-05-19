# Rules — `lib/core/`

Shared infrastructure used by all features. Nothing here is feature-specific.

---

## Modules

| Folder | Contents |
|---|---|
| `theme/` | `AppColors`, `AppTextStyles`, `AppTheme`, `ThemeProvider`, `ThemeStorage` |
| `router/` | `app_router.dart` (GoRouter + `@riverpod`) |
| `extensions/` | `ContextExtension`, `SizedBoxExtensions`, `LocalizationExtension` |
| `providers/` | `storage_providers.dart` — `sharedPreferencesProvider`, `hiveBoxProvider` |
| `constants/` | `AppConstants`, `AppRoutes`, `AppPaths`, `AppImages`, `AppIcons`, `AppBoxNames` |
| `responsive/` | `AppResponsive`, `ResponsiveLayout`, `OrientationLayout` |
| `widgets/` | Global reusable widgets |
| `errors/` | `Failures`, `Exceptions` |

---

## General Rules

- Nothing in `core/` imports from `features/`.
- Never add feature-specific logic to `core/`.
- All new global widgets go to `core/widgets/` — one file per widget.
- All new constants go to the appropriate `core/constants/` class.
- All new routes → `core/router/app_router.dart` + `AppRoutes` + `AppPaths`.
