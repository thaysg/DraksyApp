# Rules — `lib/core/providers/`

Global Riverpod providers for shared infrastructure (SharedPreferences, Hive).

---

## Files

| File | Purpose |
|---|---|
| `storage_providers.dart` | `sharedPreferencesProvider` + `hiveBoxProvider` (family) |
| `storage_providers.g.dart` | Generated — do **not** edit |

---

## `hiveBoxProvider` Rules

```dart
// Declaration (do not modify)
@riverpod
Box<dynamic> hiveBox(Ref ref, String boxName) {
  throw UnimplementedError(
    'HiveBox "$boxName" must be overridden in ProviderScope.',
  );
}
```

- This is a **family provider** — pass `AppBoxNames.*` as the argument.
- Every box must be overridden in `ProviderScope` in `main.dart`.
- **FORBIDDEN**: calling `Hive.box(...)` anywhere other than here and `main.dart`.

### Consuming a box in a provider:
```dart
// ✅ Correct
@riverpod
LessonLocalDataSource lessonLocalDataSource(Ref ref) {
  final box = ref.watch(hiveBoxProvider(AppBoxNames.lessonProgress));
  return LessonLocalDataSourceImpl(box);
}

// ❌ FORBIDDEN
final box = Hive.box<dynamic>('lesson_progress_box');
```

---

## `sharedPreferencesProvider` Rules

- Used **only** for theme mode persistence (`ThemeStorage`).
- All other local persistence → Hive.
- Also overridden in `ProviderScope` in `main.dart`.

---

## Adding a New Box

1. Add a constant to `AppBoxNames` in `lib/core/constants/app_box_names.dart`.
2. Open the box in `main.dart` before `runApp`.
3. Add the override to `ProviderScope`.
4. Consume via `hiveBoxProvider(AppBoxNames.yourBox)` in your datasource provider.
