# Rules — `lib/features/profile/`

Profile and edit-profile screens. No data or domain layer — data comes from shared auth/user providers.

---

## Structure

```
profile/
  profile_page.dart                      # Entry — dispatches to views
  presentation/
    providers/
      profile_provider.dart / .g.dart    # @riverpod profileViewProvider
    models/
      profile_view_data.dart             # ProfileViewData (Equatable DTO)
      edit_profile_view_data.dart        # EditProfileViewData (Equatable DTO)
    pages/
      edit_profile_page.dart             # Edit-profile entry point
  views/
    profile_mobile_view.dart
    profile_tablet_view.dart
    profile_desktop_view.dart
    edit_profile_mobile_view.dart
    edit_profile_tablet_view.dart
    edit_profile_desktop_view.dart
  widgets/
    profile_header.dart
    profile_stats.dart
    profile_stat_item.dart
    profile_badges_section.dart
    profile_info_section.dart
    profile_menu.dart
    profile_languages_card.dart
    profile_notifications_card.dart
    profile_actions_card.dart
    profile_support_card.dart
    edit_profile_header.dart
    edit_profile_form.dart
    edit_profile_avatar_selector.dart
```

---

## Page Rules

- `ProfilePage` and `EditProfilePage` are `ConsumerWidget`.
- Each watches its own `*ViewProvider` and handles `AsyncValue.when`.
- Dispatches to three device views via `ResponsiveLayoutBuilder`.
- `ref.watch` lives **only** in the page — never in views or widgets.

---

## View Rules

- Always `StatelessWidget`.
- Receive `ProfileViewData` or `EditProfileViewData` as required parameter.
- No `ref.watch` or provider calls.

---

## Widget Rules

- `1 file = 1 public widget class`.
- No `_build*` methods — extract to a new file in `widgets/`.
- All colors → `AppColors`.
- All text styles → `AppTextStyles`.
- All sizes → `.sp` / `.r` / `.w` / `.h`.
- Check `core/widgets/` before creating any widget (e.g. use `CustomListTile`, `CustomButton`).

### `edit_profile_form.dart`
- This is the largest widget file — do NOT add more logic here.
- If adding new form fields, extract each field to a dedicated widget in `widgets/`.

---

## Logout Rules

- Logout is triggered from `ProfileSupportCard` → calls the auth repository's `signOut` use case.
- After logout: `context.go(AppPaths.auth)`.
- The auth repository is responsible for clearing all user-specific Hive boxes on logout.

---

## Color / Style Rules

- All colors → `AppColors`. `Colors.*` is **FORBIDDEN**.
- All text → `AppTextStyles`. Inline `TextStyle(...)` is **FORBIDDEN**.
- No `withOpacity()` — use `.withValues(alpha: ...)` instead.
