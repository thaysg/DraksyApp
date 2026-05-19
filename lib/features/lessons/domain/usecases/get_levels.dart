import 'package:strawti_utils/strawti_utils.dart';
import '../../data/models/level_model.dart';
import '../repositories/lesson_repository.dart';

class GetLevels {
  const GetLevels(this._repository);
  final LessonRepository _repository;

  Future<StrautilsResponse<List<LevelModel>>> call() async =>
      _repository.getLevels();
}
