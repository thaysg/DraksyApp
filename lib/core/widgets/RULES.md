# Rules — `lib/core/widgets/`

Global reusable widgets. **Check here before creating any new widget.**

---

## Available Global Widgets

| Widget | File | Use For |
|---|---|---|
| `CustomButton` | `custom_button.dart` | All buttons (elevated / outlined / text), loading state, icon support |
| `CustomListTile` | `custom_list_tile.dart` | List items with colored icon, title, subtitle, trailing |
| `CustomDecoratedBox` | `custom_decorated_box.dart` | Decorated containers with color/gradient/border/opacity |
| `CustomScroll` | `custom_scroll.dart` | Scroll with bounce physics + automatic padding |
| `XpBar` | `xp_bar.dart` | XP progress bar with gradient |
| `HeartLivesIndicator` | `heart_lives_indicator.dart` | Lives display (hearts) |
| `DecoratedIcon` | `decorated_icon.dart` | Icon with decorated background |
| `LoadingIndicator` | `loading_indicator.dart` | Loading spinner |
| `FadeInWidget` | `fade_in_widget.dart` | Fade-in entrance animation |
| `ErrorRetryWidget` | `error_retry_widget.dart` | Error state with retry button |
| `AppTextFormField` | `app_text_form_field.dart` | Styled text input field |
| `SectionHeader` | `section_header.dart` | Section title + optional trailing action |
| `HeaderPage` | `header_page.dart` | Standard page header |
| `IconRow` | `icon_row.dart` | Row of icons |
| `CachedImageWidget` | `cached_image_widget.dart` | Cached network images |

---

## Usage Examples

```dart
// ✅ CustomButton
CustomButton(
  text: 'Continue',
  onPressed: () {},
  isLoading: false,
  type: ButtonType.elevated,
  icon: Icons.arrow_forward,
  height: 56,
)

// ✅ CustomListTile
CustomListTile(
  title: context.l10n.dailyChallenge,
  subtitle: context.l10n.dailyChallenge,
  icon: Icons.notifications_rounded,
  iconColor: AppColors.warning,
  onTap: () {},
)

// ✅ CustomDecoratedBox
CustomDecoratedBox(
  color: AppColors.primaryAppColor,
  opacity: 0.15,
  borderRadius: BorderRadius.circular(16),
  padding: const EdgeInsets.all(16),
  child: ...,
)
```

---

## Critical Rules

### FORBIDDEN — use CustomDecoratedBox instead:
```dart
// ❌ FORBIDDEN
DecoratedBox(decoration: BoxDecoration(...), child: ...)

// ✅ CORRECT
CustomDecoratedBox(color: AppColors.surface(context), child: ...)
```

### FORBIDDEN — use ConstrainedBox for constraints only:
```dart
// ❌ FORBIDDEN
Container(constraints: BoxConstraints(maxWidth: 800), child: ...)

// ✅ CORRECT
ConstrainedBox(constraints: BoxConstraints(maxWidth: 800), child: ...)
```
`Container` is only allowed when it also carries decoration, color, padding, margin, or alignment **alongside** constraints.

### CustomScroll child must NEVER be Padding:
```dart
// ❌ FORBIDDEN — double padding
CustomScroll(child: Padding(padding: ..., child: Column(...)))

// ✅ CORRECT
CustomScroll(child: Column(...))
```

---

## Adding New Global Widgets

- One file per widget in `lib/core/widgets/`.
- `const` constructors when possible.
- All colors → `AppColors`. All text → `AppTextStyles`. All sizes → `.sp` / `.r` / `.w` / `.h`.
- After adding: update this file's table above.

## `bottom_bar/`
- Custom bottom bar implementation. **Do not** replace with Flutter's native `BottomNavigationBar`.
- Only `HomeNavigation` interacts with this — do not import from features.
