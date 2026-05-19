# Rules — `lib/features/home_navigation/`

This feature is the **shell** that hosts all main tabs. It has no data layer or domain layer.

---

## Structure

```
home_navigation/
  page/
    home_navigation.dart     # Root shell widget — manages tab switching
  widgets/
    bottom_bar_widget.dart   # Custom bottom bar
    floating_button_widget.dart  # FAB center button
```

---

## Rules

### Navigation Index
- The current tab index is controlled by `navigationIndexProvider` (`StateProvider<int>`).
- **Never** manage navigation index with local state inside `HomeNavigation`.
- The FAB center button sets index to **2** (Map tab).
- Index offset logic (skipping index 2 for side tabs) lives **only** in `HomeNavigation` — do not duplicate elsewhere.

### Bottom Bar
- The custom bottom bar (`BottomBarWidget`) must **never** be replaced with Flutter's native `BottomNavigationBar`.
- All bottom bar items are declared in `lib/core/widgets/bottom_bar/bar_items.dart`.

### Widgets
- `bottom_bar_widget.dart` and `floating_button_widget.dart` are the only widgets in this feature.
- Do NOT add data fetching or provider watches here — this widget is a pure navigation shell.
- `1 file = 1 public widget class` — always.
- No `_build*` methods — extract to new files in `widgets/` if needed.

### Colors
- All colors via `AppColors` — `Colors.*` is **FORBIDDEN**.

### Sizing
- All sizes via `.sp` / `.r` / `.w` / `.h` — raw numbers are **FORBIDDEN**.
