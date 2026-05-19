import '../models/lesson_progress_model.dart';
import '../models/node_model.dart';

/// Contract for lesson-related local storage operations.
abstract class LessonLocalDataSource {
  /// Returns the progress record for [unitId] / [nodeId], or `null` if absent.
  Future<LessonProgressModel?> getProgress({
    required String unitId,
    required String nodeId,
  });

  /// Persists [model] to local storage (upsert).
  Future<void> saveProgress(LessonProgressModel model);

  /// Returns all progress records stored locally.
  Future<List<LessonProgressModel>> getAllProgress();

  /// Returns pre-generated nodes for [lessonId], or `null` if absent.
  Future<List<NodeModel>?> getNodes(String lessonId);

  /// Persists pre-generated [nodes] for [lessonId].
  Future<void> saveNodes(String lessonId, List<NodeModel> nodes);

  /// Removes all cached progress (e.g. on logout).
  Future<void> clearAll();
}
