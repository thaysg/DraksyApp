import 'dart:convert';

import '../../../../core/local/hive_cache_keys.dart';
import '../../../../core/local/local_data_base.dart';
import '../models/lesson_progress_model.dart';
import '../models/node_model.dart';
import 'lesson_local_data_source.dart';

/// Local data source implementation for lesson progress using [LocalDataBase].
class LessonLocalDataSourceImpl implements LessonLocalDataSource {
  const LessonLocalDataSourceImpl(this._localDb);

  final LocalDataBase _localDb;

  @override
  Future<LessonProgressModel?> getProgress({
    required String unitId,
    required String nodeId,
  }) async {
    final key = HiveCacheKeys.lessonProgressKey(unitId, nodeId);
    return _localDb.read<LessonProgressModel>(key);
  }

  @override
  Future<void> saveProgress(LessonProgressModel model) async {
    final key = HiveCacheKeys.lessonProgressKey(model.unitId, model.nodeId);
    await _localDb.write(key, model);
  }

  @override
  Future<List<LessonProgressModel>> getAllProgress() async =>
      _localDb.readAll<LessonProgressModel>(
        HiveCacheKeys.lessonProgressBox,
      );

  @override
  Future<List<NodeModel>?> getNodes(String lessonId) async {
    final key = HiveCacheKeys.lessonNodesKey(lessonId);
    final raw = await _localDb.read<String>(key); //Salva como String JSON
    if (raw == null) {
      return null;
    }
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => NodeModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<void> saveNodes(String lessonId, List<NodeModel> nodes) async {
    final key = HiveCacheKeys.lessonNodesKey(lessonId);
    final data = jsonEncode(nodes.map((e) => e.toJson()).toList());
    await _localDb.write(key, data); // String is saved as JSON
  }

  @override
  Future<void> clearAll() async {
    // In this new architecture, we can clear the whole user data from
    //auth repository,
    // but if specifically asked to clear this box:
    // HiveLocalDataBase could have a clearBox method if needed.
    // For now, we can use the clearUserData from the core local db if it's
    // what's intended.
    // Or we could implement delete for each key if we had them.
    // Since HiveLocalDataBase in reference has clearUserData targeting
    // specific boxes,
    // we use that via auth repository mostly.
    await _localDb.clearUserData();
  }
}
