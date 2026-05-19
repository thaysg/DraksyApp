import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';
import '../models/feed_activity_model.dart';
import '../models/feed_friend_model.dart';
import '../models/feed_ranking_model.dart';
import '../models/feed_weekly_challenge_model.dart';

/// Implementation of [FeedRepository].
class FeedRepositoryImpl extends StrautilsTryThis implements FeedRepository {
  FeedRepositoryImpl({
    required FeedRemoteDataSource remote,
  }) : _remote = remote;

  final FeedRemoteDataSource _remote;

  @override
  Future<StrautilsResponse<List<FeedFriendModel>>> getFriends() async =>
      tryThis(
        () async {
          final friends = await _remote.getFriends();
          return StrautilsResponse.success(friends);
        },
        action: 'fetch friends',
      );

  @override
  Future<StrautilsResponse<FeedWeeklyChallengeModel?>>
      getWeeklyChallenge() async => tryThis(
            () async {
              final challenge = await _remote.getWeeklyChallenge();
              return StrautilsResponse.success(challenge);
            },
            action: 'fetch weekly challenge',
          );

  @override
  Future<StrautilsResponse<PaginationResponse<FeedActivityModel>>>
      getActivities(PaginationRequest request) async => tryThis(
            () async {
              final response = await _remote.getActivities(request);
              return StrautilsResponse.success(response);
            },
            action: 'fetch activities',
          );

  @override
  Future<StrautilsResponse<List<FeedRankingModel>>>
      getWeeklyLeaderboard() async => tryThis(
            () async {
              final leaderboard = await _remote.getWeeklyLeaderboard();
              return StrautilsResponse.success(leaderboard);
            },
            action: 'fetch weekly leaderboard',
          );
}
