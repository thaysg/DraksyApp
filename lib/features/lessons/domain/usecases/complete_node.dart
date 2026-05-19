import 'package:strawti_utils/strawti_utils.dart';

import '../repositories/lesson_repository.dart';

/// Use case to mark a lesson node as completed.
class CompleteNode {
  const CompleteNode(this._repository);

  final LessonRepository _repository;

  Future<StrautilsResponse<void>> call({
    required String unitId,
    required String nodeId,
    required String lessonId,
    required int xpEarned,
    double accuracy = 0.0,
  }) async =>
      _repository.completeNode(
        unitId: unitId,
        nodeId: nodeId,
        lessonId: lessonId,
        xpEarned: xpEarned,
        accuracy: accuracy,
      );
}
