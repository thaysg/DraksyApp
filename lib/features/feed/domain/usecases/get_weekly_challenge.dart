import 'package:strawti_utils/strawti_utils.dart';

import '../../data/models/feed_weekly_challenge_model.dart';
import '../repositories/feed_repository.dart';

/// Use case to fetch the weekly challenge.
class GetWeeklyChallenge {
  const GetWeeklyChallenge(this._repository);

  final FeedRepository _repository;

  Future<StrautilsResponse<FeedWeeklyChallengeModel?>> call() async =>
      _repository.getWeeklyChallenge();
}
