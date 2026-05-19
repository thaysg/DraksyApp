# Rules — `lib/features/`

> Each feature lives in its own subdirectory. See the feature's own `RULES.md` for specifics.

---

## Feature Folder Conventions

### Features WITH data layer (full Clean Architecture)
```
lib/features/<feature>/
  presentation/
    pages/         # Screen widgets (StatelessWidget / ConsumerWidget)
    views/         # Mobile / Tablet / Desktop view widgets
    widgets/       # Feature-scoped reusable widgets
    providers/     # @riverpod providers + .g.dart
    models/        # *ViewData DTOs
  data/
    datasources/   # Interface + implementation
    models/        # @HiveType / DTO models
    repositories/  # Repository implementations
    providers/     # @riverpod datasource/repo providers
  domain/
    entities/      # Pure domain entities (no framework dependency)
    repositories/  # Repository interfaces (abstract)
    usecases/      # Use cases — one action per file
```

### Features WITHOUT data layer (simple / navigation-only)
```
lib/features/<feature>/
  page/            # OR presentation/pages/
  widgets/
```

---

## Responsive Page Pattern (MANDATORY for every page)

Every page with responsive layout **MUST** have views for all three device types:

```
<feature>_page.dart          # Entry point — async state + dispatches to views
views/
  <feature>_mobile_view.dart
  <feature>_tablet_view.dart
  <feature>_desktop_view.dart
widgets/                     # Shared widgets used by all views
```

- Views are **always** `StatelessWidget` — never `ConsumerWidget`.
- `ref.watch` lives **only** in the Page widget.
- Pages with async data collect all state into a `*ViewData` model, then pass to views.
- `*ViewData` classes (DTOs) for the same screen may share one file — the "1 file = 1 class" rule applies to **widget classes only**.

---

## Current Features

| Feature | Has Data Layer | Has Domain Layer |
|---|---|---|
| `auth` | ✅ | ✅ |
| `lessons` | ✅ | ✅ |
| `home` | ❌ | ❌ |
| `home_navigation` | ❌ | ❌ |
| `profile` | ❌ | ❌ |
| `settings` | ❌ | ❌ |
| `shop` | ❌ | ❌ |
| `intro` | ❌ | ❌ |
| `splash` | ❌ | ❌ |

---

## Adding a New Feature — Checklist

```
[ ] Create folder under lib/features/<feature>/
[ ] Add routes to app_router.dart + AppRoutes + AppPaths
[ ] Add ViewData model if page has async data
[ ] Add mobile/tablet/desktop views
[ ] Add @riverpod providers (never manual providers)
[ ] If local data: add Hive box to AppBoxNames, open in main.dart, inject via ProviderScope
[ ] Add all user-visible strings to app_en.arb + app_pt.arb
```
