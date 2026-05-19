import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../data/models/lesson_progress_model.dart';
import '../repositories/lesson_repository.dart';

/// Use case to fetch user progress history with pagination.
class GetUserProgress {
  const GetUserProgress(this._repository);

  final LessonRepository _repository;

  Future<StrautilsResponse<PaginationResponse<LessonProgressModel>>> call(
    PaginationRequest request,
  ) async =>
      _repository.getUserProgress(request);
}
