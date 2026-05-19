# Rules — `test/`

Testing rules for the Draksy project. All new features **must** include tests following these conventions before a PR is considered complete.

---

## Stack

| Tool | Purpose |
|---|---|
| `flutter_test` | Widget tests and unit tests |
| `mocktail` | Mocking — never use `mockito` |
| `flutter_riverpod` | `ProviderContainer` and `ProviderScope` overrides |
| `flutter_screenutil` | Required wrapper for any widget under test |
| `go_router` | `InheritedGoRouter` for pages that use navigation |

---

## Folder Structure

Mirror `lib/` exactly. Every file in `lib/` that contains testable logic has a corresponding `_test.dart` file.

```
test/
  core/
    errors/
    extensions/
    widgets/
    theme/
  features/
    <feature>/
      data/
        datasources/    # <datasource>_impl_test.dart
        repositories/   # <repository>_impl_test.dart
      domain/
        usecases/       # <use_case>_test.dart
      presentation/
        pages/          # <page>_test.dart
        providers/      # <provider>_test.dart
```

---

## What to Test per Layer

### Domain — Use Cases
Every use case gets its own test file. Use cases are thin delegates to the repository, so tests are minimal but still required.

- ✅ Returns success when repository returns success
- ✅ Returns error when repository returns error
- ✅ Passes arguments correctly to repository (`verify`)

```dart
class MockAuthRepository extends Mock implements AuthRepository {}

test('returns success when repository returns success', () async {
  when(() => mockRepository.signInWithGoogle())
      .thenAnswer((_) async => StrautilsResponse.success(tUser));

  final result = await useCase();

  expect(result.success, isTrue);
  verify(() => mockRepository.signInWithGoogle()).called(1);
});
```

---

### Data — Repository Implementations
Test all public methods. Use mocks for both the remote data source and local database.

- ✅ Returns success response on happy path
- ✅ Returns error response when data source throws
- ✅ Calls correct data source methods (`verify`)
- ✅ Clears local database on logout/account deletion
- ✅ Does NOT clear local database if remote call fails (`verifyNever`)

---

### Data — Local Data Sources (`*Impl`)
Mock `LocalDataBase`. Verify the exact cache key used for every read/write.

- ✅ Returns model on cache hit
- ✅ Returns null on cache miss
- ✅ Writes with the correct composite key (e.g. `HiveCacheKeys.lessonProgressKey(unitId, nodeId)`)
- ✅ Reads from the correct box name

```dart
test('calls localDb.read with the correct composite key', () async {
  when(() => mockLocalDb.read<LessonProgressModel>(any()))
      .thenAnswer((_) async => null);

  await dataSource.getProgress(unitId: 'unit1', nodeId: 'node1');

  verify(() => mockLocalDb.read<LessonProgressModel>(
    HiveCacheKeys.lessonProgressKey('unit1', 'node1'),
  )).called(1);
});
```

---

### Presentation — Providers (Unit Tests)
Use `ProviderContainer` directly — no widgets needed.

- ✅ Correct initial state
- ✅ State changes after each action (`toggle`, `set`, `clear`, etc.)
- ✅ Side effects on other providers (e.g. `AuthTypeNotifier.toggle` resets `emailConfirmationSentProvider`)
- ✅ Error handling / fallback values

Always call `addTearDown(container.dispose)`:

```dart
ProviderContainer makeContainer() {
  final container = ProviderContainer(overrides: [...]);
  addTearDown(container.dispose);
  return container;
}
```

For `@riverpod class` notifiers (state notifiers), override with a subclass — never use `(ref) => value`:

```dart
// ❌ wrong — notifier providers don't accept a value factory
selectedOptionProvider.overrideWith((ref) => -1)

// ✅ correct — subclass overrides build()
class _MockSelectedOptionMinus1 extends SelectedOption {
  @override
  int build() => -1;
}
selectedOptionProvider.overrideWith(_MockSelectedOptionMinus1.new)
```

For simple `@riverpod` function providers, the value factory is correct:

```dart
// ✅ correct for function providers
homeViewProvider.overrideWith((ref) => Future.value(tData))
lessonsPathViewProvider('title').overrideWith((ref) => tData)
```

---

### Presentation — Pages (Widget Tests)
Every page must have widget tests covering all three async states where applicable.

**Required test cases:**
- ✅ Loading state — verifies skeleton/loading widget is present
- ✅ Data state — verifies key content is visible (use unique data values to avoid false positives)
- ✅ Error state — verifies `ErrorRetryWidget` with `find.text('Try again')`
- ✅ Key actions — logout, delete account, navigation, button taps

**Data state pattern — always use unique values:**
```dart
final tData = HomeViewData(
  userName: 'UniqueHomeUser',   // unique string — avoids matching other widgets
  xp: '998877',                 // unique number
  ...
);

expect(find.text('UniqueHomeUser'), findsOneWidget);
expect(find.text('998877'), findsOneWidget);
```

---

## Widget Test Setup (Mandatory Boilerplate)

Every widget test must include:

```dart
Widget createWidgetUnderTest() => ProviderScope(
  overrides: [...],
  child: ScreenUtilInit(
    designSize: const Size(360, 690),  // use 1000×2000 for tablet/desktop pages
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, _) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: /* your page */,
    ),
  ),
);
```

For pages that use `context.push` / `context.pop`, wrap in `InheritedGoRouter`:

```dart
home: InheritedGoRouter(
  goRouter: mockRouter,
  child: const YourPage(),
),
```

---

## Physical Size — Always Set It

The default Flutter test viewport is `800×600`. Widgets built for `360×690` will render off-screen and taps will miss. Set `physicalSize` in every widget test:

```dart
testWidgets('...', (tester) async {
  tester.view.physicalSize = const Size(360, 690);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  // ...
});
```

Use `ensureVisible` before tapping elements that might be off-screen:

```dart
final button = find.byIcon(Icons.visibility_off_outlined).first;
await tester.ensureVisible(button);
await tester.tap(button);
```

---

## `pump` vs `pumpAndSettle`

| Situation | Use |
|---|---|
| Normal widget render | `await tester.pumpAndSettle()` |
| Widget has `CircularProgressIndicator` | `await tester.pump()` |
| Widget has infinite `AnimationController.repeat()` | `await tester.pump(const Duration(seconds: N))` |
| Widget has a fixed-duration animation (e.g. 1500ms) | `await tester.pump(const Duration(milliseconds: 2000))` |

> **Rule:** If `pumpAndSettle` times out, there is an infinite animation in the widget tree. Find it and switch to `pump(Duration)`.

Known pages with infinite animations:
- `LessonsPathPage` — `LessonPathCurrentNode` uses `AnimationController..repeat()`. Use `pump(const Duration(seconds: 3))`.

---

## Image Assets in Tests

Widgets that render `Image.asset(path)` will throw `Unable to load asset` in tests because the asset bundle is not available. Fix: wrap the widget under test in a `DefaultAssetBundle` with a fake bundle that implements `CachingAssetBundle`.

```dart
class _FakeAssetBundle extends CachingAssetBundle {
  static const _kTransparentPng = <int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
    0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
    0x54, 0x78, 0x9C, 0x62, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
    0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
    0x42, 0x60, 0x82,
  ];

  @override
  Future<ByteData> load(String key) async =>
      Uint8List.fromList(_kTransparentPng).buffer.asByteData();

  // Required: AssetImage calls this to load AssetManifest.bin.
  // Returning an empty StandardMessageCodec map makes AssetImage
  // fall back to scale 1.0 without throwing.
  @override
  Future<T> loadStructuredBinaryData<T>(
    String key,
    FutureOr<T> Function(ByteData data) parser,
  ) async {
    final encoded =
        const StandardMessageCodec().encodeMessage(<Object, Object>{})!;
    return parser(encoded);
  }
}

// Usage:
Widget createWidgetUnderTest() => DefaultAssetBundle(
  bundle: _FakeAssetBundle(),
  child: ProviderScope(...),
);
```

> **Important:** Extend `CachingAssetBundle`, not `Fake implements AssetBundle`. The `Fake` base class throws `UnimplementedError` for any method not explicitly overridden, which will break `loadStructuredBinaryData` called internally by Flutter.

---

## What NOT to Test

- **Hardcoded / mocked providers**: If a provider returns a compile-time constant (no repository call, no logic), skip unit tests for that provider. The value of testing `expect(data.gems, '450')` is zero. Write the test once the backend is connected.
- **`AppColors` constants**: Testing that a color hex value equals itself is not a meaningful test. The existing `test/core/theme/app_colors_test.dart` file falls into this category — those tests should be removed or skipped when refactoring. Do not add new ones.
- **Generated files** (`*.g.dart`): Never test generated code.
- **Pure layout widgets** with no logic (e.g. `StaticDivider`, `SpacingWidget`).

---

## Checklist — New Feature

When a new feature is added or an existing one gains a backend connection, the following tests are required before merging:

```
[ ] Use cases (domain layer)
    [ ] success path
    [ ] error path
    [ ] argument forwarding (verify)

[ ] Repository implementation (data layer)
    [ ] success path for each public method
    [ ] error path for each public method
    [ ] side effects (local DB clear, verify/verifyNever)

[ ] Local data source implementation (if feature has local cache)
    [ ] read hit / miss
    [ ] write with correct key
    [ ] readAll with correct box name
    [ ] clear

[ ] Providers (presentation layer)
    [ ] initial state
    [ ] state after each action
    [ ] side effects on dependent providers

[ ] Page widget tests
    [ ] loading state
    [ ] data state (unique values)
    [ ] error state (find.text('Try again'))
    [ ] primary actions (taps, navigation, logout, etc.)
```

---

## Pending Tests (known gaps as of current codebase)

These are not yet covered and should be added when the corresponding backend is implemented:

| Area | File to create |
|---|---|
| `AuthRemoteDataSourceImpl` | `test/features/auth/data/datasources/auth_remote_data_source_impl_test.dart` |
| `ProfileProvider` / `profileViewProvider` logic | `test/features/profile/presentation/providers/profile_provider_test.dart` |
| `SettingsProvider` / `settingsViewProvider` logic | `test/features/settings/presentation/providers/settings_provider_test.dart` |
| `EditProfilePage` widget test | `test/features/profile/presentation/pages/edit_profile_page_test.dart` |