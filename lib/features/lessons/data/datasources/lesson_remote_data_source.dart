import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../models/lesson_progress_model.dart';
import '../models/level_model.dart';
import '../models/node_model.dart';
import '../models/unit_model.dart';

/// Contract for lesson-related remote data operations.
abstract class LessonRemoteDataSource {
  /// Fetches available levels from Supabase.
  Future<List<LevelModel>> getLevels();

  /// Fetches units for a specific difficulty level with pagination.
  Future<PaginationResponse<UnitModel>> getUnitsByDifficulty({
    required String difficulty,
    required PaginationRequest request,
  });

  /// Fetches the number of completed lessons for a specific difficulty.
  Future<int> getCompletedLessonsCount(String difficulty);

  /// Fetches pre-generated lesson nodes from Supabase.
  ///
  /// This invokes the 'generate-lesson' Edge Function, which either
  /// returns cached nodes from the DB or calls Gemini to generate them.
  Future<List<NodeModel>> getLessonNodes(String lessonId);

  /// Fetches accuracy progress for a list of units.
  Future<Map<String, double>> getUnitsProgress(List<String> unitIds);

  /// Fetches user progress history with pagination.
  Future<PaginationResponse<LessonProgressModel>> getUserProgress(
    PaginationRequest request,
  );

  /// Saves the completion progress for a lesson node.
  Future<void> saveNodeProgress({
    required String unitId,
    required String nodeId,
    required String lessonId,
    required int xpEarned,
    double accuracy = 0.0,
  });
}
