# Rules — `lib/core/responsive/`

Responsive layout utilities. Used by every page and view.

---

## Files

| File | Purpose |
|---|---|
| `app_responsive.dart` | `AppResponsive` — static helpers (breakpoints, padding, grid columns) |
| `responsive_layout.dart` | `ResponsiveLayoutBuilder` widget — dispatches by `DeviceType` |
| `orientation_layout.dart` | `OrientationLayout` — portrait vs landscape dispatch |

---

## Breakpoints

| Device | Width Range |
|---|---|
| Mobile | `< 600px` |
| Tablet | `600px – 899px` |
| Desktop | `>= 900px` |

---

## How to Use

### In widgets (preferred):
```dart
context.isMobile
context.isTablet
context.isDesktop
context.screenWidth
context.screenHeight
context.horizontalPadding     // 32 mobile/tablet | 64 desktop
context.maxContentWidth        // 800 desktop | 600 tablet | infinity mobile
context.gridColumns            // 1, 2, 3, or 4
context.isPortrait
context.isLandscape
```

### In pages (dispatching views):
```dart
ResponsiveLayoutBuilder(
  builder: (context, deviceType) => switch (deviceType) {
    DeviceType.mobile  => MyMobileView(data: data),
    DeviceType.tablet  => MyTabletView(data: data),
    DeviceType.desktop => MyDesktopView(data: data),
  },
)
```

### Outside widgets / when context extension is not available:
```dart
AppResponsive.isMobile(context)
AppResponsive.isTablet(context)
AppResponsive.isDesktop(context)
AppResponsive.horizontalPadding(context)
AppResponsive.maxContentWidth(context)
AppResponsive.gridColumns(context)
```

---

## Rules

- **Every page with responsive layout** must have three views: mobile, tablet, desktop.
- Use `context.*` extension inside widgets.
- Use `AppResponsive.*` when no `BuildContext` extension is available (rare).
- `ResponsiveLayoutBuilder` is the **only** mechanism for device-type dispatch — do not use inline `if (context.isMobile)` at the page level.

---

## CustomScroll Padding Rule (CRITICAL)

`CustomScroll` applies `horizontalPadding` and `vertical: 20` internally via `SingleChildScrollView`.

```dart
// ❌ FORBIDDEN — double padding
CustomScroll(
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(...),
  ),
)

// ✅ CORRECT — no extra Padding wrapper
CustomScroll(
  child: Column(...),
)
```

The child of `CustomScroll` is **never** a `Padding` widget.
