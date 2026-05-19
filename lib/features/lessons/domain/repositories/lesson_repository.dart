import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../data/models/lesson_progress_model.dart';
import '../../data/models/level_model.dart';
import '../../data/models/node_model.dart';
import '../../data/models/unit_model.dart';

/// Repository contract for the lessons feature.
abstract class LessonRepository {
  /// Fetches available levels.
  Future<StrautilsResponse<List<LevelModel>>> getLevels();

  /// Fetches the number of completed lessons for a specific difficulty.
  Future<StrautilsResponse<int>> getCompletedLessonsCount(String difficulty);

  /// Fetches units for a specific difficulty level with pagination.
  Future<StrautilsResponse<PaginationResponse<UnitModel>>>
      getUnitsByDifficulty({
    required String difficulty,
    required PaginationRequest request,
  });

  /// Fetches nodes for a lesson, using local cache if available.
  Future<StrautilsResponse<List<NodeModel>>> getLessonNodes(String lessonId);

  /// Fetches progress for specific units.
  Future<StrautilsResponse<Map<String, double>>> getUnitsProgress(
      List<String> unitIds);

  /// Fetches user progress history with pagination.
  Future<StrautilsResponse<PaginationResponse<LessonProgressModel>>>
      getUserProgress(PaginationRequest request);

  /// Marks a lesson node/unit as completed.
  Future<StrautilsResponse<void>> completeNode({
    required String unitId,
    required String nodeId,
    required String lessonId,
    required int xpEarned,
    double accuracy = 0.0,
  });
}
