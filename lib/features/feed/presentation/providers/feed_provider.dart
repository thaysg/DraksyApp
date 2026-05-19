import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/providers/feed_usecase_providers.dart';
import '../models/feed_view_data.dart';

part 'feed_provider.g.dart';

@riverpod
Future<FeedViewData> feedView(Ref ref) async {
  // Watch auth to potentially personalize feed
  final user = await ref.watch(authProvider.future);

  final getFriends = ref.watch(getFriendsProvider);
  final getWeeklyChallenge = ref.watch(getWeeklyChallengeProvider);
  final getWeeklyLeaderboard = ref.watch(getWeeklyLeaderboardProvider);

  final results = await Future.wait([
    getFriends(),
    getWeeklyChallenge(),
    getWeeklyLeaderboard(),
  ]);

  final friendsResponse = results[0] as dynamic;
  final challengeResponse = results[1] as dynamic;
  final leaderboardResponse = results[2] as dynamic;

  final friends = (friendsResponse.data as List<dynamic>?) ?? [];
  final challenge = challengeResponse.data;
  final leaderboard = (leaderboardResponse.data as List<dynamic>?) ?? [];

  debugPrint('feedViewProvider: mapping ${friends.length}'
      ' friends and ${leaderboard.length} rankings');

  return FeedViewData(
    stories: [
      FeedStoryData(
        name: user?.displayName ?? 'Você',
        photoUrl: user?.photoURL ?? 'https://i.pravatar.cc/150?u=me',
        isMe: true,
        isOnline: true,
        hasUpdate: true,
      ),
      ...friends.map((f) => FeedStoryData(
            name: f.name,
            photoUrl: f.photoUrl,
            isMe: false,
            isOnline: f.isOnline,
            hasUpdate: f.hasUpdate,
          )),
    ],
    weeklyChallenge: FeedWeeklyChallengeData(
      title: challenge?.title ?? 'Weekly Challenge',
      description: challenge?.description ?? '',
      completedLessons: challenge?.completedLessons ?? 0,
      totalLessons: challenge?.totalLessons ?? 1,
      remainingTime: challenge?.remainingTime ?? '0h',
    ),
    rankings: leaderboard
        .map<FeedRankingData>((r) => FeedRankingData(
              userId: r.userId,
              userName: r.userName,
              userPhotoUrl: r.userPhotoUrl,
              xp: r.xp,
              position: r.position,
              isMe: r.isMe,
            ))
        .toList(),
  );
}
