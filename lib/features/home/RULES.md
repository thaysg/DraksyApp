# Rules — `lib/features/home/`

The home screen. No data or domain layer — data comes from shared providers.

---

## Structure

```
home/
  home_page.dart                    # Entry point — watches homeViewProvider, dispatches to views
  presentation/
    providers/
      home_provider.dart            # @riverpod homeViewProvider
      home_provider.g.dart          # generated
    models/
      home_view_data.dart           # HomeViewData (Equatable DTO)
  views/
    home_mobile_view.dart
    home_tablet_view.dart
    home_desktop_view.dart
  widgets/
    home_header.dart
    stat_cards_section.dart
    stat_item.dart
    stat_vertical_divider.dart
    daily_challenge_card.dart
    daily_challenge_progress_bar.dart
    lesson_progress_card.dart
```

---

## Page Rules (`home_page.dart`)

- `HomePage` is a `ConsumerWidget`.
- It watches `homeViewProvider` and handles `AsyncValue.when(data/loading/error)`.
- On `data`: dispatches to the correct view via `ResponsiveLayoutBuilder`.
- On `loading`: renders `LoadingIndicator()`.
- On `error`: renders `ErrorRetryWidget(onRetry: () => ref.refresh(homeViewProvider))`.
- `ref.watch` lives **only** here — never in views or widgets.

```dart
// ✅ Correct dispatch pattern
ResponsiveLayoutBuilder(
  builder: (context, deviceType) => switch (deviceType) {
    DeviceType.mobile  => HomeMobileView(data: data),
    DeviceType.tablet  => HomeTabletView(data: data),
    DeviceType.desktop => HomeDesktopView(data: data),
  },
)
```

---

## View Rules (`views/`)

- Views are **always** `StatelessWidget` — NEVER `ConsumerWidget`.
- They receive `HomeViewData data` as a required constructor parameter.
- They delegate data to child widgets — no business logic here.

### Mobile Layout
- Root: `CustomScroll` (never wrap its child in `Padding` — double padding!).
- Vertical `Column` with all sections.
- Bottom clearance: `80–100.heightBox`.

### Tablet Layout
- Root: `CustomScroll`.
- Two-column `Row` with `Expanded(flex: 3)` / `Expanded(flex: 2)`.
- Column gap: `32.widthBox`.

### Desktop Layout
- Root: `CustomScroll` → `Center` → `ConstrainedBox(maxWidth: AppResponsive.maxContentWidth(context))`.
- Two-column `Row` layout with `40.widthBox` gap.
- Bottom clearance: `100.heightBox`.

### Section Spacing

| Gap | Mobile | Tablet | Desktop |
|---|---|---|---|
| Header → content | `20` | `24` | `32` |
| Between sections | `20–32` | `32–40` | `40–48` |
| Bottom clearance | `80–100` | `80–100` | `100` |

---

## Widget Rules (`widgets/`)

- `1 file = 1 public widget class`.
- No `_build*` methods — extract to a new file.
- All colors → `AppColors` (no `Colors.*`).
- All text styles → `AppTextStyles` (no inline `TextStyle`).
- All sizes → `.sp` / `.r` / `.w` / `.h`.
- Use `SizedBoxExtensions`: `8.heightBox`, `16.widthBox`, etc.
- Check `core/widgets/` before creating any new widget.

---

## Known Violations to NEVER Repeat

```dart
// ❌ home_page.dart — was using Colors.amber (line 38)
iconColor: Colors.amber,
// ✅ Fix:
iconColor: AppColors.secondaryLight,
```

---

## `HomeViewData` Rules

- Defined in `presentation/models/home_view_data.dart`.
- Extends `Equatable`.
- All fields are required.
- Multiple related DTO classes for the same screen may live in one file (not widget classes).
