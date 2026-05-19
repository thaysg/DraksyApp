# Rules — `lib/features/settings/`

Settings screen. No data or domain layer.

---

## Structure

```
settings/
  settings_page.dart                       # Entry — dispatches to views
  presentation/
    providers/
      settings_provider.dart / .g.dart     # @riverpod settingsViewProvider
    models/
      settings_view_data.dart              # SettingsViewData (Equatable DTO)
  views/
    settings_mobile_view.dart
    settings_tablet_view.dart
    settings_desktop_view.dart
  widgets/
    settings_item.dart
    settings_general_card.dart
    settings_learning_card.dart
    settings_notifications_card.dart
    settings_preferences_card.dart
```

---

## Page Rules

- `SettingsPage` is a `ConsumerWidget`.
- Watches `settingsViewProvider`, handles `AsyncValue.when`.
- Dispatches to views via `ResponsiveLayoutBuilder`.
- `ref.watch` lives **only** here.

---

## View Rules

- Always `StatelessWidget`.
- Receive `SettingsViewData data` as required parameter.
- No `ref.watch`.

### Mobile / Tablet
- Root: `CustomScroll` (never wrap child in `Padding`).
- Vertical `Column` with settings cards stacked.
- Bottom clearance: `80–100.heightBox`.

### Desktop
- Root: `CustomScroll` → `Center` → `ConstrainedBox(maxWidth: AppResponsive.maxContentWidth(context))`.

---

## Widget Rules

- `1 file = 1 public widget class`.
- No `_build*` methods.
- All colors → `AppColors`.
- All text styles → `AppTextStyles`.
- Prefer `CustomListTile` from `core/widgets/` for list items — check `SettingsItem` first.
- All sizes → `.sp` / `.r` / `.w` / `.h`.

---

## Theme / Localization Rules

- Theme mode changes go through `themeProvider` — never set `ThemeMode` directly.
- All user-visible strings → `context.l10n.*`. Hardcoded strings are **FORBIDDEN**.
