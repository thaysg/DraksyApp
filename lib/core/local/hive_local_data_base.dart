import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../../features/lessons/data/models/lesson_progress_model.dart';
import 'hive_cache_keys.dart';
import 'local_data_base.dart';

/// Hive-backed cache using `boxName__innerKey` composite keys.
class HiveLocalDataBase implements LocalDataBase {
  HiveLocalDataBase();

  /// Initializes Hive and registers all TypeAdapters.
  /// Must be called once before any box operation.
  static Future<void> initialize() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  static void _registerAdapters() {
    Hive.registerAdapter(LessonProgressModelAdapter());
    // novos adapters entram aqui
  }

  final Map<String, Box<dynamic>> _openedBoxes = {};

  /// Returns the Hive box segment from a composite cache key (`box__innerKey`).
  String _extractBoxName(String key) =>
      key.split(HiveCacheKeys.separator).first;

  /// Returns the item key segment from a composite cache key (`box__innerKey`).
  String _extractInnerKey(String key) {
    final parts = key.split(HiveCacheKeys.separator);
    return parts.length > 1 ? parts[1] : key;
  }

  /// Opens the target box once and reuses it from the in-memory box cache.
  Future<Box<dynamic>> _openBoxIfNeeded(String key) async {
    final boxName = _extractBoxName(key);

    if (_openedBoxes.containsKey(boxName)) {
      return _openedBoxes[boxName]!;
    }

    final box = await Hive.openBox<dynamic>(boxName);
    _openedBoxes[boxName] = box;
    return box;
  }

  @override
  Future<void> write(String key, Object? value) async {
    final box = await _openBoxIfNeeded(key);
    final innerKey = _extractInnerKey(key);
    await box.put(innerKey, value);
  }

  @override
  Future<T?> read<T>(String key) async {
    final box = await _openBoxIfNeeded(key);
    final innerKey = _extractInnerKey(key);
    final value = box.get(innerKey);

    if (value == null) {
      return null;
    }
    return _normalizeForRead(value) as T?;
  }

  /// Converts nested dynamic maps/lists into JSON-like structures with string keys.
  Object? _normalizeForRead(Object? value) {
    if (value is Map) {
      return value.map(
        (key, nestedValue) =>
            MapEntry(key.toString(), _normalizeForRead(nestedValue)),
      );
    }

    if (value is List) {
      return value.map(_normalizeForRead).toList();
    }

    return value;
  }

  @override
  Future<void> delete(String key) async {
    final box = await _openBoxIfNeeded(key);
    final innerKey = _extractInnerKey(key);
    await box.delete(innerKey);
  }

  @override
  Future<bool> exists(String key) async {
    final box = await _openBoxIfNeeded(key);
    final innerKey = _extractInnerKey(key);
    return box.containsKey(innerKey);
  }

  @override
  Future<void> clear() async {
    debugPrint('HiveLocalDataBase : all opened boxes cache has been cleared');
    for (final box in _openedBoxes.values) {
      await box.clear();
    }
    _openedBoxes.clear();
  }

  @override
  Future<List<T>> readAll<T>(String boxName) async {
    final box = _openedBoxes[boxName] ?? await Hive.openBox<dynamic>(boxName);
    _openedBoxes[boxName] = box;
    return box.values.whereType<T>().toList();
  }

  @override
  Future<void> clearUserData() async {
    debugPrint('HiveLocalDataBase : user-scoped cache has been cleared');
    for (final boxName in HiveCacheKeys.userScopedBoxes) {
      try {
        final box = _openedBoxes.remove(boxName) ??
            await Hive.openBox<dynamic>(boxName);
        await box.clear();
        await box.close();
      } catch (_) {}
    }
  }
}
