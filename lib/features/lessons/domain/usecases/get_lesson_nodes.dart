import 'package:strawti_utils/strawti_utils.dart';

import '../../data/models/node_model.dart';
import '../repositories/lesson_repository.dart';

/// Use case to fetch lesson nodes.
class GetLessonNodes {
  const GetLessonNodes(this._repository);

  final LessonRepository _repository;

  Future<StrautilsResponse<List<NodeModel>>> call(String lessonId) async =>
      _repository.getLessonNodes(lessonId);
}
