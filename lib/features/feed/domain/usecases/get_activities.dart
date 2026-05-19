import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../data/models/feed_activity_model.dart';
import '../repositories/feed_repository.dart';

/// Use case to fetch feed activities with pagination.
class GetActivities {
  const GetActivities(this._repository);

  final FeedRepository _repository;

  Future<StrautilsResponse<PaginationResponse<FeedActivityModel>>> call(
    PaginationRequest request,
  ) async =>
      _repository.getActivities(request);
}
