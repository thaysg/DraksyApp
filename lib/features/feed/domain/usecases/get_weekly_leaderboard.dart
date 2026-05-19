import 'package:strawti_utils/strawti_utils.dart';

import '../../data/models/feed_ranking_model.dart';
import '../repositories/feed_repository.dart';

/// Use case to fetch the weekly leaderboard.
class GetWeeklyLeaderboard {
  const GetWeeklyLeaderboard(this._repository);

  final FeedRepository _repository;

  Future<StrautilsResponse<List<FeedRankingModel>>> call() async =>
      _repository.getWeeklyLeaderboard();
}
