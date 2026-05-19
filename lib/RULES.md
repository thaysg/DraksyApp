# Rules — `lib/`

> See the full rule set in `flutter_code_rules_draksy.md`.
> This file covers **top-level structure only**.

---

## Folder Responsibilities

| Folder | Purpose |
|---|---|
| `features/` | All feature modules (one folder per feature) |
| `core/` | Shared infrastructure: theme, routing, extensions, widgets, constants |
| `services/` | Low-level services not tied to a feature (e.g. Firestore helper) |
| `l10n/` | Localization ARB files and generated classes |
| `main.dart` | App entry point — initializes Firebase, Hive, runs `ProviderScope` |
| `app.dart` | Root `MaterialApp.router` widget |
| `firebase_options.dart` | Auto-generated — **never edit manually** |
| `injection_container.dart` | Legacy GetIt — kept for compatibility, do **not** add new deps here |

---

## `main.dart` Rules

- Initialize Firebase **before** `runApp`.
- Initialize Hive with `Hive.initFlutter()` before `runApp`.
- Call `_registerHiveAdapters()` (all `Hive.registerAdapter` calls live here).
- Open every Hive box here and inject via `ProviderScope` overrides.
- `SharedPreferences` also initialized here and injected via override.
- Never open Hive boxes anywhere else.

---

## `app.dart` Rules

- Root widget is `MaterialApp.router` using `appRouterProvider`.
- Theme is controlled by `themeProvider` — never set `ThemeMode` directly.
- Uses `useMaterial3: true` — never disable.
- `ScreenUtil` design size: `360 × 690`.

---

## General Dart File Rules

- `snake_case.dart` for file names.
- `PascalCase` for class names.
- **1 public widget class per file** (a `StatefulWidget` + its private `_State` is ONE widget — allowed).
- Private `_build*` methods inside widgets are **FORBIDDEN** — extract to a separate file in `widgets/`.
- Import order: `dart:*` → `package:flutter/*` → external packages → internal (relative paths).
