import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../data/models/feed_activity_model.dart';
import '../../data/models/feed_friend_model.dart';
import '../../data/models/feed_ranking_model.dart';
import '../../data/models/feed_weekly_challenge_model.dart';

/// Repository contract for the feed feature.
abstract class FeedRepository {
  /// Fetches friends list with streak status.
  Future<StrautilsResponse<List<FeedFriendModel>>> getFriends();

  /// Fetches the active weekly challenge.
  Future<StrautilsResponse<FeedWeeklyChallengeModel?>> getWeeklyChallenge();

  /// Fetches activities from friends with pagination.
  Future<StrautilsResponse<PaginationResponse<FeedActivityModel>>>
      getActivities(PaginationRequest request);

  /// Fetches the top 3 users in the weekly XP leaderboard.
  Future<StrautilsResponse<List<FeedRankingModel>>> getWeeklyLeaderboard();
}
