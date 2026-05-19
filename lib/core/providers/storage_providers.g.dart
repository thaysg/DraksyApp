// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for SharedPreferences instance.
/// Needs to be overridden in ProviderScope in main.dart.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider for SharedPreferences instance.
/// Needs to be overridden in ProviderScope in main.dart.

final class SharedPreferencesProvider extends $FunctionalProvider<
    SharedPreferences,
    SharedPreferences,
    SharedPreferences> with $Provider<SharedPreferences> {
  /// Provider for SharedPreferences instance.
  /// Needs to be overridden in ProviderScope in main.dart.
  SharedPreferencesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sharedPreferencesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'b1d7640ffbdaefca7bbd1b92369fd8a6f55fa44f';

/// Provider for the local database abstraction.

@ProviderFor(localDataBase)
final localDataBaseProvider = LocalDataBaseProvider._();

/// Provider for the local database abstraction.

final class LocalDataBaseProvider
    extends $FunctionalProvider<LocalDataBase, LocalDataBase, LocalDataBase>
    with $Provider<LocalDataBase> {
  /// Provider for the local database abstraction.
  LocalDataBaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'localDataBaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$localDataBaseHash();

  @$internal
  @override
  $ProviderElement<LocalDataBase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDataBase create(Ref ref) {
    return localDataBase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDataBase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDataBase>(value),
    );
  }
}

String _$localDataBaseHash() => r'8111a14d633437e5feeecc9e3a75149ccb8e5bf6';

/// Provider for a Hive [Box] identified by [boxName].
///
/// Each box must be opened before runApp and overridden in ProviderScope:
///
/// ```dart
/// final userBox = await Hive.openBox<Map>(AppBoxNames.user);
///
/// ProviderScope(
///   overrides: [
///     hiveBoxProvider(AppBoxNames.user).overrideWithValue(userBox),
///   ],
///   child: const AppWidget(),
/// );
/// ```
///
/// Then consume in any provider or widget:
///
/// ```dart
/// final box = ref.watch(hiveBoxProvider(AppBoxNames.user));
/// ```

@ProviderFor(hiveBox)
final hiveBoxProvider = HiveBoxFamily._();

/// Provider for a Hive [Box] identified by [boxName].
///
/// Each box must be opened before runApp and overridden in ProviderScope:
///
/// ```dart
/// final userBox = await Hive.openBox<Map>(AppBoxNames.user);
///
/// ProviderScope(
///   overrides: [
///     hiveBoxProvider(AppBoxNames.user).overrideWithValue(userBox),
///   ],
///   child: const AppWidget(),
/// );
/// ```
///
/// Then consume in any provider or widget:
///
/// ```dart
/// final box = ref.watch(hiveBoxProvider(AppBoxNames.user));
/// ```

final class HiveBoxProvider
    extends $FunctionalProvider<Box<dynamic>, Box<dynamic>, Box<dynamic>>
    with $Provider<Box<dynamic>> {
  /// Provider for a Hive [Box] identified by [boxName].
  ///
  /// Each box must be opened before runApp and overridden in ProviderScope:
  ///
  /// ```dart
  /// final userBox = await Hive.openBox<Map>(AppBoxNames.user);
  ///
  /// ProviderScope(
  ///   overrides: [
  ///     hiveBoxProvider(AppBoxNames.user).overrideWithValue(userBox),
  ///   ],
  ///   child: const AppWidget(),
  /// );
  /// ```
  ///
  /// Then consume in any provider or widget:
  ///
  /// ```dart
  /// final box = ref.watch(hiveBoxProvider(AppBoxNames.user));
  /// ```
  HiveBoxProvider._(
      {required HiveBoxFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'hiveBoxProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hiveBoxHash();

  @override
  String toString() {
    return r'hiveBoxProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Box<dynamic>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<dynamic> create(Ref ref) {
    final argument = this.argument as String;
    return hiveBox(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<dynamic>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HiveBoxProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hiveBoxHash() => r'3b48da57e4d0a4aa38242050aaef72c7085eb5d3';

/// Provider for a Hive [Box] identified by [boxName].
///
/// Each box must be opened before runApp and overridden in ProviderScope:
///
/// ```dart
/// final userBox = await Hive.openBox<Map>(AppBoxNames.user);
///
/// ProviderScope(
///   overrides: [
///     hiveBoxProvider(AppBoxNames.user).overrideWithValue(userBox),
///   ],
///   child: const AppWidget(),
/// );
/// ```
///
/// Then consume in any provider or widget:
///
/// ```dart
/// final box = ref.watch(hiveBoxProvider(AppBoxNames.user));
/// ```

final class HiveBoxFamily extends $Family
    with $FunctionalFamilyOverride<Box<dynamic>, String> {
  HiveBoxFamily._()
      : super(
          retry: null,
          name: r'hiveBoxProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a Hive [Box] identified by [boxName].
  ///
  /// Each box must be opened before runApp and overridden in ProviderScope:
  ///
  /// ```dart
  /// final userBox = await Hive.openBox<Map>(AppBoxNames.user);
  ///
  /// ProviderScope(
  ///   overrides: [
  ///     hiveBoxProvider(AppBoxNames.user).overrideWithValue(userBox),
  ///   ],
  ///   child: const AppWidget(),
  /// );
  /// ```
  ///
  /// Then consume in any provider or widget:
  ///
  /// ```dart
  /// final box = ref.watch(hiveBoxProvider(AppBoxNames.user));
  /// ```

  HiveBoxProvider call(
    String boxName,
  ) =>
      HiveBoxProvider._(argument: boxName, from: this);

  @override
  String toString() => r'hiveBoxProvider';
}
