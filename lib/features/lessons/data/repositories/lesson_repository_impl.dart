import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../datasources/lesson_local_data_source.dart';
import '../datasources/lesson_remote_data_source.dart';
import '../models/lesson_progress_model.dart';
import '../models/level_model.dart';
import '../models/node_model.dart';
import '../models/unit_model.dart';

/// Implementation of [LessonRepository] using [StrautilsTryThis].
class LessonRepositoryImpl extends StrautilsTryThis
    implements LessonRepository {
  LessonRepositoryImpl({
    required LessonLocalDataSource local,
    required LessonRemoteDataSource remote,
  })  : _local = local,
        _remote = remote;

  final LessonLocalDataSource _local;
  final LessonRemoteDataSource _remote;

  @override
  Future<StrautilsResponse<List<LevelModel>>> getLevels() async => tryThis(
        () async {
          final levels = await _remote.getLevels();
          return StrautilsResponse.success(levels);
        },
        action: 'fetch levels',
      );

  @override
  Future<StrautilsResponse<int>> getCompletedLessonsCount(
    String difficulty,
  ) async =>
      tryThis(
        () async {
          final count = await _remote.getCompletedLessonsCount(difficulty);
          return StrautilsResponse.success(count);
        },
        action: 'fetch completed lessons count',
      );

  @override
  Future<StrautilsResponse<PaginationResponse<UnitModel>>>
      getUnitsByDifficulty({
    required String difficulty,
    required PaginationRequest request,
  }) async =>
          tryThis(
            () async {
              final response = await _remote.getUnitsByDifficulty(
                difficulty: difficulty,
                request: request,
              );
              return StrautilsResponse.success(response);
            },
            action: 'fetch units',
          );

  @override
  Future<StrautilsResponse<List<NodeModel>>> getLessonNodes(
    String lessonId,
  ) async =>
      tryThis(
        () async {
          final cached = await _local.getNodes(lessonId);
          if (cached != null) {
            return StrautilsResponse.success(cached);
          }

          final nodes = await _remote.getLessonNodes(lessonId);
          await _local.saveNodes(lessonId, nodes);

          return StrautilsResponse.success(nodes);
        },
        action: 'fetch lesson nodes',
        // tryAgain: () => getLessonNodes(lessonId),
      );

  @override
  Future<StrautilsResponse<void>> completeNode({
    required String unitId,
    required String nodeId,
    required String lessonId,
    required int xpEarned,
    double accuracy = 0.0,
  }) async =>
      tryThis(
        () async {
          // Save locally first for offline support
          await _local.saveProgress(LessonProgressModel(
            unitId: unitId,
            nodeId: nodeId,
            isCompleted: true,
            xpEarned: xpEarned,
            accuracy: accuracy,
            completedAt: DateTime.now().toIso8601String(),
          ));

          // Sync with remote
          await _remote.saveNodeProgress(
            unitId: unitId,
            nodeId: nodeId,
            lessonId: lessonId,
            xpEarned: xpEarned,
            accuracy: accuracy,
          );

          return StrautilsResponse.success(null);
        },
        action: 'complete lesson node',
        tryAgain: () => completeNode(
          unitId: unitId,
          nodeId: nodeId,
          lessonId: lessonId,
          xpEarned: xpEarned,
          accuracy: accuracy,
        ),
      );

  @override
  Future<StrautilsResponse<Map<String, double>>> getUnitsProgress(
    List<String> unitIds,
  ) async =>
      tryThis(
        () async {
          // 1. Get remote progress
          final remoteProgress = await _remote.getUnitsProgress(unitIds);

          // 2. Get local progress
          final allLocal = await _local.getAllProgress();
          final localProgress = <String, double>{};
          for (final p in allLocal) {
            if (unitIds.contains(p.unitId)) {
              // Only keep highest accuracy if multiple nodes/attempts
              if (!localProgress.containsKey(p.unitId) ||
                  p.accuracy > localProgress[p.unitId]!) {
                localProgress[p.unitId] = p.accuracy;
              }
            }
          }

          // 3. Merge (local takes priority if more recent/higher,
          // but usually remote is truth. Here we combine for offline-first)
          final combined = <String, double>{
            ...remoteProgress,
            ...localProgress
          };

          return StrautilsResponse.success(combined);
        },
        action: 'fetch units progress',
      );

  @override
  Future<StrautilsResponse<PaginationResponse<LessonProgressModel>>>
      getUserProgress(PaginationRequest request) async => tryThis(
            () async {
              final response = await _remote.getUserProgress(request);
              return StrautilsResponse.success(response);
            },
            action: 'fetch user progress',
          );
}
