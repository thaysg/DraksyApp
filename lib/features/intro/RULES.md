# Rules — `lib/features/intro/`

Onboarding / intro carousel screen.

---

## Structure

```
intro/
  presentation/
    pages/
      intro_page.dart                      # Entry — dispatches to views
    views/
      intro_mobile_view.dart
      intro_tablet_view.dart
      intro_desktop_view.dart
    providers/
      intro_providers.dart / .g.dart       # @riverpod introViewProvider
    models/
      intro_view_data.dart                 # IntroViewData (Equatable DTO)
    widgets/
      intro_card.dart
      intro_page_view.dart
      intro_indicator.dart
      intro_action_button.dart
      intro_login_text.dart
```

---

## Page Rules

- `IntroPage` is a `ConsumerWidget`.
- Watches `introViewProvider`, handles `AsyncValue.when`.
- Dispatches to views via `ResponsiveLayoutBuilder`.
- `ref.watch` lives **only** here.

---

## View Rules

- Always `StatelessWidget`.
- Receive `IntroViewData data` as required parameter.
- No `ref.watch`.

---

## Widget Rules

- `1 file = 1 public widget class`.
- No `_build*` methods.
- All colors → `AppColors`. `Colors.*` is **FORBIDDEN**.
- All text styles → `AppTextStyles`. Inline `TextStyle` is **FORBIDDEN**.
- All sizes → `.sp` / `.r` / `.w` / `.h`.
- All user-visible strings → `context.l10n.*`.

---

## Navigation After Intro

- After completing intro → `context.go(AppPaths.auth)`.
- **FORBIDDEN**: `Navigator.push` or `Navigator.pushReplacement`.
