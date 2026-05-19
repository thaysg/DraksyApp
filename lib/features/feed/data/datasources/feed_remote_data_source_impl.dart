import '../../../../core/utils/models/pagination_request.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../models/feed_activity_model.dart';
import '../models/feed_friend_model.dart';
import '../models/feed_ranking_model.dart';
import '../models/feed_weekly_challenge_model.dart';
import 'feed_remote_data_source.dart';

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  const FeedRemoteDataSourceImpl();

  @override
  Future<List<FeedFriendModel>> getFriends() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const FeedFriendModel(
        id: '1',
        name: 'Alex Dragon',
        photoUrl: 'https://ui-avatars.com/api/?name=Alex+Dragon&background=random',
        streak: 15,
        isMe: false,
        isOnline: true,
        hasUpdate: true,
      ),
      const FeedFriendModel(
        id: '2',
        name: 'Luna Moon',
        photoUrl: 'https://ui-avatars.com/api/?name=Luna+Moon&background=random',
        streak: 42,
        isMe: false,
        isOnline: false,
        hasUpdate: false,
      ),
      const FeedFriendModel(
        id: '3',
        name: 'Sparky',
        photoUrl: 'https://ui-avatars.com/api/?name=Sparky&background=random',
        streak: 7,
        isMe: false,
        isOnline: true,
        hasUpdate: false,
      ),
    ];
  }

  @override
  Future<FeedWeeklyChallengeModel?> getWeeklyChallenge() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const FeedWeeklyChallengeModel(
      title: 'Weekly Dragon Quest',
      description: 'Complete 10 lessons this week to earn a rare badge!',
      completedLessons: 4,
      totalLessons: 10,
      remainingTime: '3d 12h',
    );
  }

  @override
  Future<PaginationResponse<FeedActivityModel>> getActivities(
    PaginationRequest request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final activities = [
      FeedActivityModel(
        id: 'a1',
        userName: 'Alex Dragon',
        userPhotoUrl: 'https://ui-avatars.com/api/?name=Alex+Dragon&background=random',
        type: 'lesson',
        description: 'completed "Basic Greetings"',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        likes: 5,
        value: '+15 XP',
        isOnline: true,
        isLiked: false,
      ),
      FeedActivityModel(
        id: 'a2',
        userName: 'Luna Moon',
        userPhotoUrl: 'https://ui-avatars.com/api/?name=Luna+Moon&background=random',
        type: 'lesson',
        description: 'reached a 40-day streak!',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        likes: 12,
        value: 'STREAK',
        isOnline: false,
        isLiked: true,
      ),
    ];

    return PaginationResponse(
      items: activities,
      totalCount: activities.length,
      currentPage: 1,
      lastPage: 1,
    );
  }

  @override
  Future<List<FeedRankingModel>> getWeeklyLeaderboard() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      const FeedRankingModel(
        userId: '2',
        userName: 'Luna Moon',
        userPhotoUrl: 'https://ui-avatars.com/api/?name=Luna+Moon&background=random',
        xp: '2500',
        position: 1,
        isMe: false,
      ),
      const FeedRankingModel(
        userId: '1',
        userName: 'Alex Dragon',
        userPhotoUrl: 'https://ui-avatars.com/api/?name=Alex+Dragon&background=random',
        xp: '1800',
        position: 2,
        isMe: false,
      ),
      const FeedRankingModel(
        userId: 'me',
        userName: 'You',
        userPhotoUrl: 'https://ui-avatars.com/api/?name=You&background=random',
        xp: '1200',
        position: 3,
        isMe: true,
      ),
    ];
  }
}
