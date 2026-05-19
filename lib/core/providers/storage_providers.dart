import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/hive_local_data_base.dart';
import '../local/local_data_base.dart';

part 'storage_providers.g.dart';

/// Provider for SharedPreferences instance.
/// Needs to be overridden in ProviderScope in main.dart.
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'SharedPreferences must be overridden in ProviderScope',
  );
}

/// Provider for the local database abstraction.
@riverpod
LocalDataBase localDataBase(Ref ref) => HiveLocalDataBase();

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
@riverpod
Box<dynamic> hiveBox(Ref ref, String boxName) {
  throw UnimplementedError(
    'HiveBox "$boxName" must be overridden in ProviderScope.',
  );
}
