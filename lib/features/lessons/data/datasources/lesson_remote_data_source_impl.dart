import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../models/lesson_progress_model.dart';
import '../models/level_model.dart';
import '../models/node_content_model.dart';
import '../models/node_model.dart';
import '../models/unit_model.dart';
import 'lesson_remote_data_source.dart';

class LessonRemoteDataSourceImpl implements LessonRemoteDataSource {
  const LessonRemoteDataSourceImpl();

  @override
  Future<List<LevelModel>> getLevels() async => [
        const LevelModel(
          id: '1',
          name: 'Level 1',
          description: 'Beginner basics',
          orderIndex: 1,
          lessonCount: 10,
          languageTarget: 'Spanish',
        ),
        const LevelModel(
          id: '2',
          name: 'Level 2',
          description: 'Common phrases',
          orderIndex: 2,
          lessonCount: 15,
          languageTarget: 'Spanish',
        ),
      ];

  @override
  Future<PaginationResponse<UnitModel>> getUnitsByDifficulty({
    required String difficulty,
    required PaginationRequest request,
  }) async {
    final units = [
      UnitModel(
        id: 'u1',
        orderIndex: 1,
        title: 'Greetings',
        description: 'Learn basic greetings',
        difficulty: difficulty,
        languageTarget: 'Spanish',
        lessonId: 'l1',
      ),
      UnitModel(
        id: 'u2',
        orderIndex: 2,
        title: 'Numbers',
        description: 'Learn numbers 1-10',
        difficulty: difficulty,
        languageTarget: 'Spanish',
        lessonId: 'l3',
      ),
    ];

    return PaginationResponse(
      items: units,
      totalCount: units.length,
      currentPage: 1,
      lastPage: 1,
    );
  }

  @override
  Future<int> getCompletedLessonsCount(String difficulty) async => 3;

  @override
  Future<List<NodeModel>> getLessonNodes(String lessonId) async => [
        const NodeModel(
          id: 'n1',
          lessonId: 'l1',
          orderIndex: 1,
          type: 'question',
          content: QuestionContentModel(
            question: 'How do you say "Hello"?',
            options: [
              QuestionOptionModel(text: 'Hola', emoji: '👋'),
              QuestionOptionModel(text: 'Adiós', emoji: '👋'),
              QuestionOptionModel(text: 'Gracias', emoji: '🙏'),
            ],
            correctIndex: 0,
            explanation: '"Hola" means hello in Spanish.',
          ),
        ),
        const NodeModel(
          id: 'n2',
          lessonId: 'l1',
          orderIndex: 2,
          type: 'question',
          content: QuestionContentModel(
            question: 'How do you say "Good morning"?',
            options: [
              QuestionOptionModel(text: 'Buenos días', emoji: '🌅'),
              QuestionOptionModel(text: 'Buenas noches', emoji: '🌙'),
              QuestionOptionModel(text: 'Buenas tardes', emoji: '☀️'),
            ],
            correctIndex: 0,
            explanation: '"Buenos días" is the standard morning greeting.',
          ),
        ),
      ];

  @override
  Future<PaginationResponse<LessonProgressModel>> getUserProgress(
    PaginationRequest request,
  ) async =>
      PaginationResponse.empty();

  @override
  Future<void> saveNodeProgress({
    required String unitId,
    required String nodeId,
    required String lessonId,
    required int xpEarned,
    double accuracy = 0.0,
  }) async {
    // Mock: Do nothing in portfolio
  }

  @override
  Future<Map<String, double>> getUnitsProgress(List<String> unitIds) async =>
      {for (final id in unitIds) id: 0.8};
}
