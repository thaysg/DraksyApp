# Rules — `lib/features/auth/`

Authentication feature. Full Clean Architecture with presentation, data, and domain layers.

---

## Structure

```
auth/
  presentation/
    pages/
      auth_page.dart                      # Entry — dispatches to views
    views/
      auth_mobile_view.dart
      auth_tablet_view.dart
      auth_desktop_view.dart
    providers/
      auth_providers.dart                 # @riverpod: authProvider, authStateProvider, etc.
      auth_providers.g.dart
    models/
      auth_view_data.dart                 # AuthViewData DTO
    widgets/
      auth_form.dart
      auth_header.dart
      auth_social_buttons.dart
      social_auth_button.dart
      auth_switch_text.dart
  data/
    datasources/
      auth_remote_data_source.dart        # Abstract interface
      auth_remote_data_source_impl.dart   # Firebase/Google impl
    models/
      user_model.dart                     # UserModel (DTO — maps to/from Firestore)
    repositories/
      auth_repository_impl.dart           # Implements domain/repositories/auth_repository.dart
  domain/
    entities/
      user.dart                           # Pure User entity (no framework deps)
    repositories/
      auth_repository.dart                # Abstract interface
    usecases/
      sign_in_with_email.dart
      sign_in_with_google.dart
      sign_up_with_email.dart
```

---

## Presentation Rules

- `AuthPage` is a `ConsumerWidget` — handles async state and dispatches to views.
- Views are **always** `StatelessWidget` — never `ConsumerWidget`.
- `ref.watch` lives only in `AuthPage`.
- All state goes through `authProviders` — no local auth state in widgets.

---

## Data Layer Rules

### DataSource
- `AuthRemoteDataSource` (interface) — no Firebase imports, pure contract.
- `AuthRemoteDataSourceImpl` — only place that touches Firebase Auth / Google Sign-In.
- Uses `StrautilsTryThis` (`tryThis(...)`) for all error wrapping.

### Repository
- `AuthRepositoryImpl` implements the domain interface.
- On **logout**: clears all user-specific Hive boxes (lesson progress, daily challenge, etc.).
  - Do **NOT** clear `settings_box` — that is device-level, not user-level.

```dart
// ✅ Required in AuthRepositoryImpl.signOut()
await lessonLocalDataSource.clearAll();
await dailyChallengeLocalDataSource.clearAll();
// Do NOT: await settingsLocalDataSource.clearAll();
```

---

## Domain Layer Rules

- `User` entity: pure Dart class, zero Flutter/Firebase imports.
- `AuthRepository` (interface): lives in domain — no implementation details.
- Use cases: one file per action (`sign_in_with_email.dart`, etc.).

---

## Provider Rules

- All providers use `@riverpod` with code generation.
- Always include `part 'auth_providers.g.dart';`.
- Never use manual `StateNotifierProvider` or `Provider(...)`.
- `Auth` notifier uses `Stream<User?>` from `authRepositoryProvider`.

```dart
// ✅ Correct
@riverpod
class Auth extends _$Auth {
  @override
  Stream<User?> build() => ref.watch(authRepositoryProvider).userChanges;
}
```

---

## Navigation Rules

- After sign-in success → `context.go(AppPaths.home)`.
- After sign-out → `context.go(AppPaths.auth)`.
- **FORBIDDEN**: `Navigator.push(context, MaterialPageRoute(...))`.

---

## Color / Style Rules

- All colors → `AppColors`. `Colors.*` is **FORBIDDEN**.
- All text → `AppTextStyles`. Inline `TextStyle(...)` is **FORBIDDEN**.
- All sizes → `.sp` / `.r` / `.w` / `.h`.
