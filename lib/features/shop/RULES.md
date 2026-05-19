# Rules — `lib/features/shop/`

Shop / premium screen. No data or domain layer.

---

## Structure

```
shop/
  shop_page.dart                       # Entry — dispatches to views
  presentation/
    providers/
      shop_provider.dart / .g.dart     # @riverpod shopViewProvider
    models/
      shop_view_data.dart              # ShopViewData (Equatable DTO)
  views/
    shop_mobile_view.dart
    shop_tablet_view.dart
    shop_desktop_view.dart
  widgets/
    shop_header.dart
    shop_sidebar.dart
    shop_sidebar_item.dart
    shop_plans_section.dart
    shop_plan_card.dart
    shop_power_ups_section.dart
    shop_power_up_item.dart
    product_grid.dart
    shop_counter_button.dart
    shop_stat_pill.dart
```

---

## Page Rules

- `ShopPage` is a `ConsumerWidget` (or `StatelessWidget` if no async data).
- Dispatches to views via `ResponsiveLayoutBuilder`.
- `ref.watch` lives **only** here.

---

## View Rules

- Always `StatelessWidget`.
- Receive `ShopViewData data` as required parameter (or `const` if no data).

### Mobile / Tablet
- Root: `CustomScroll` → `Column`.
- `ShopSidebar` is hidden on mobile — show only on desktop.

### Desktop — Sidebar Pattern
- Root: `CustomScroll` → top-level `Row` (sidebar left, content right).
- Sidebar on the left, `Expanded` content on the right.

```dart
// ✅ Desktop sidebar pattern
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
            // sections...
            100.heightBox,
          ],
        ),
      ),
    ],
  ),
)
```

---

## Widget Rules

- `1 file = 1 public widget class`.
- No `_build*` methods.
- All colors → `AppColors`. `Colors.*` is **FORBIDDEN**.
- All text styles → `AppTextStyles`.
- All sizes → `.sp` / `.r` / `.w` / `.h`.
- Check `core/widgets/` first (e.g. `CustomButton`, `CustomDecoratedBox`).

---

## Color / Style Notes

- Premium accent colors: use `AppColors.premiumNavy` and `AppColors.premiumPurple` for premium UI elements.
- Gradient cards: use `AppColors.premiumGradient`.
- Gold: use `AppColors.gold` — never `Colors.yellow` or `Colors.amber`.
