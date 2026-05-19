import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../models/feed_activity_model.dart';
import '../models/feed_friend_model.dart';
import '../models/feed_ranking_model.dart';
import '../models/feed_weekly_challenge_model.dart';

/// Contract for feed-related remote data operations.
abstract class FeedRemoteDataSource {
  /// Fetches friends list with streak status for the current user.
  Future<List<FeedFriendModel>> getFriends();

  /// Fetches the active weekly challenge for the current user.
  Future<FeedWeeklyChallengeModel?> getWeeklyChallenge();

  /// Fetches activities from friends with pagination.
  Future<PaginationResponse<FeedActivityModel>> getActivities(
    PaginationRequest request,
  );

  /// Fetches the top 3 users in the weekly XP leaderboard.
  Future<List<FeedRankingModel>> getWeeklyLeaderboard();
}
