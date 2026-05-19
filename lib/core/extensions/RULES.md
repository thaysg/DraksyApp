# Rules — `lib/core/extensions/`

Dart extension methods for convenience. Used project-wide.

---

## Files

| File | Extension | Purpose |
|---|---|---|
| `context_extension.dart` | `BuildContextX` on `BuildContext` | Responsive helpers, theme, brightness |
| `spacing.dart` | `SizedBoxExtension` on `num` | Quick `SizedBox` creation |
| `localization_extension.dart` | `LocalizationX` on `BuildContext` | `context.l10n` shorthand |

---

## Spacing Extensions — REQUIRED

```dart
// ✅ CORRECT — always use these
8.heightBox      // SizedBox(height: 8)
16.widthBox      // SizedBox(width: 16)
24.squareBox     // SizedBox(height: 24, width: 24)

// ❌ FORBIDDEN
SizedBox(height: 8)
SizedBox(width: 16)
```

---

## Context Extensions — REQUIRED

```dart
// Responsive
context.isMobile
context.isTablet
context.isDesktop
context.screenWidth
context.screenHeight
context.horizontalPadding
context.maxContentWidth
context.gridColumns
context.isPortrait
context.isLandscape

// Theme
context.isDarkMode         // equivalent to Theme.of(context).brightness == Brightness.dark
```

---

## Localization Extension — REQUIRED

```dart
// ✅ CORRECT
context.l10n.dailyChallenge
context.l10n.continueLearning
context.l10n.unitLesson(3, 2)  // parameterized strings

// ❌ FORBIDDEN — hardcoded strings
'Daily Challenge'
'Continue Learning'
```

---

## Rules

- All user-visible strings must go through `context.l10n.*`.
- New extension methods go in the appropriate file (context, spacing, localization).
- Do not create new extension files without a good reason — prefer adding to existing files.
