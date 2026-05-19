# Rules — `lib/core/theme/`

Design system: colors, typography, and theme configuration.

---

## Files

| File | Purpose |
|---|---|
| `app_colors.dart` | All color constants and theme-aware color helpers |
| `app_text_styles.dart` | All text styles using `GoogleFonts.nunito()` |
| `app_theme.dart` | `AppTheme.lightTheme(context)` / `AppTheme.darkTheme(context)` |
| `theme_provider.dart` | `@riverpod themeProvider` — controls `ThemeMode` |
| `theme_storage.dart` | Persists theme mode via `SharedPreferences` |

---

## AppColors Rules

### FORBIDDEN everywhere in the codebase:
```dart
Colors.white / Colors.black / Colors.transparent
Colors.grey / Colors.red / Colors.amber / Colors.orange
Colors.green / Colors.blue / Colors.purple / Colors.yellow
Color(0xFFxxxxxx)   // any raw hex color
```

### Required substitutions:
| Forbidden | Use Instead |
|---|---|
| `Colors.white` | `AppColors.surfaceLight` or `AppColors.textPrimaryDark` |
| `Colors.black` | `AppColors.backgroundDark` or `AppColors.textPrimaryLight` |
| `Colors.transparent` | `AppColors.transparent` |
| `Colors.grey` | `AppColors.textSecondary(context)` or `AppColors.textSecondaryLight` |
| `Colors.amber` | `AppColors.secondaryLight` _(Amber Gold — #FF8F00)_ |
| `Colors.orange` | `AppColors.accent` or `AppColors.rpgOrange` |
| `Colors.red` | `AppColors.primaryAppColor` or `AppColors.error` or `AppColors.hp` |
| `Colors.green` | `AppColors.success` or `AppColors.green` |
| `Colors.blue` | `AppColors.mana` or `AppColors.info` |
| `Colors.purple` | `AppColors.purple` |
| `Colors.yellow` | `AppColors.gold` or `AppColors.secondaryDark` |
| `Color(0xFF...)` | Define in `AppColors` or use the closest existing constant |

### withOpacity() is FORBIDDEN — use withValues():
```dart
// ❌ FORBIDDEN
AppColors.primaryAppColor.withOpacity(0.5)

// ✅ CORRECT
AppColors.primaryAppColor.withValues(alpha: 0.5)
```

### Adding new colors
- New colors must be added as a named constant in `AppColors`, not inline.
- Theme-aware colors (require `BuildContext`) → use a static method.
- Fixed colors (no context) → use a `static const`.

---

## AppTextStyles Rules

### FORBIDDEN:
```dart
// ❌ Inline TextStyle
Text('Title', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
```

### Required:
```dart
// ✅ Always use AppTextStyles
Text(context.l10n.dailyChallenge, style: AppTextStyles.h3(context))
Text(context.l10n.dailyChallenge, style: AppTextStyles.bodyMedium(context))
Text(context.l10n.dailyChallenge, style: AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.w900))
```

### Available Styles
| Style | Size | Weight |
|---|---|---|
| `h1(context)` | 32sp | 800 |
| `h2(context)` | 28sp | 800 |
| `h3(context)` | 24sp | 700 |
| `h4(context)` | 20sp | 700 |
| `bodyLarge(context)` | 16sp | 400 |
| `bodyMedium(context)` | 14sp | 600 |
| `bodySmall(context)` | 12sp | 400 |
| `buttonLarge(context)` | 12sp | 700 |
| `buttonMedium(context)` | 14sp | 700 |
| `appBarTitle(context)` | 20sp | 800 |
| `titleMedium(context)` | 16sp | 700 |
| `error(context)` | — | — |
| `success(context)` | — | — |
| `warning(context)` | — | — |
| `primaryText(context)` | — | — |

---

## AppTheme Rules

- `useMaterial3: true` — **never** disable.
- Never set `ThemeMode` directly — always use `themeProvider`.
- Access brightness in widgets: `context.isDarkMode` or `Theme.of(context).brightness`.

## ThemeStorage Rules

- Uses `SharedPreferences` (via `sharedPreferencesProvider`).
- This is the **only** `SharedPreferences` use case — all other local storage uses Hive.
