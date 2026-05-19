import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../data/models/unit_model.dart';
import '../repositories/lesson_repository.dart';

/// Use case to fetch units by difficulty with pagination.
class GetUnitsByDifficulty {
  const GetUnitsByDifficulty(this._repository);

  final LessonRepository _repository;

  Future<StrautilsResponse<PaginationResponse<UnitModel>>> call({
    required String difficulty,
    required PaginationRequest request,
  }) async =>
      _repository.getUnitsByDifficulty(
        difficulty: difficulty,
        request: request,
      );
}
