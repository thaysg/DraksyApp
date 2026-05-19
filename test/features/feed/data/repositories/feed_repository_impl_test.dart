import 'package:draksy/core/utils/models/pagination_request.dart';
import 'package:draksy/core/utils/models/pagination_response.dart';
import 'package:draksy/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:draksy/features/feed/data/models/feed_activity_model.dart';
import 'package:draksy/features/feed/data/models/feed_friend_model.dart';
import 'package:draksy/features/feed/data/models/feed_ranking_model.dart';
import 'package:draksy/features/feed/data/models/feed_weekly_challenge_model.dart';
import 'package:draksy/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFeedRemoteDataSource extends Mock implements FeedRemoteDataSource {}

void main() {
  late MockFeedRemoteDataSource mockRemoteDataSource;
  late FeedRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const PaginationRequest(page: 1, limit: 10));
  });

  setUp(() {
    mockRemoteDataSource = MockFeedRemoteDataSource();
    repository = FeedRepositoryImpl(remote: mockRemoteDataSource);
  });

  group('getFriends', () {
    const tFriends = [
      FeedFriendModel(
        id: '1',
        name: 'Friend',
        photoUrl: '',
        isMe: false,
        isOnline: true,
        hasUpdate: false,
        streak: 5,
      ),
    ];

    test('must return success with friends list when remote call is successful',
        () async {
      when(() => mockRemoteDataSource.getFriends())
          .thenAnswer((_) async => tFriends);

      final result = await repository.getFriends();

      expect(result.data, tFriends);
      verify(() => mockRemoteDataSource.getFriends()).called(1);
    });

    test('should return error when remote call fails', () async {
      when(() => mockRemoteDataSource.getFriends())
          .thenThrow(Exception('Server error'));

      final result = await repository.getFriends();

      expect(result.error, isTrue);
      expect(result.message, contains('fetch friends'));
    });
  });

  group('getWeeklyChallenge', () {
    const tChallenge = FeedWeeklyChallengeModel(
      title: 'Title',
      description: 'Desc',
      completedLessons: 5,
      totalLessons: 10,
      remainingTime: '1d',
    );

    test('should return success with challenge when remote call is successful',
        () async {
      when(() => mockRemoteDataSource.getWeeklyChallenge())
          .thenAnswer((_) async => tChallenge);

      final result = await repository.getWeeklyChallenge();

      expect(result.data, tChallenge);
      verify(() => mockRemoteDataSource.getWeeklyChallenge()).called(1);
    });
  });

  group('getActivities', () {
    final tActivities = [
      FeedActivityModel(
        id: '1',
        userName: 'User',
        userPhotoUrl: '',
        type: 'lesson',
        description: 'Desc',
        createdAt: DateTime.now(),
        likes: 0,
        value: '+10',
      ),
    ];

    final tPaginationResponse = PaginationResponse<FeedActivityModel>(
      items: tActivities,
      totalCount: 1,
      currentPage: 1,
      lastPage: 1,
    );

    test('should return success with activities when remote call is successful',
        () async {
      when(() => mockRemoteDataSource.getActivities(any()))
          .thenAnswer((_) async => tPaginationResponse);

      final result = await repository.getActivities(
        const PaginationRequest(page: 1, limit: 10),
      );

      expect(result.data, tPaginationResponse);
      verify(() => mockRemoteDataSource.getActivities(any())).called(1);
    });
  });

  group('getWeeklyLeaderboard', () {
    const tLeaderboard = [
      FeedRankingModel(
        userId: '1',
        userName: 'User',
        userPhotoUrl: '',
        xp: '100',
        position: 1,
      ),
    ];

    test(
        'should return success with leaderboard when remote call is successful',
        () async {
      when(() => mockRemoteDataSource.getWeeklyLeaderboard())
          .thenAnswer((_) async => tLeaderboard);

      final result = await repository.getWeeklyLeaderboard();

      expect(result.data, tLeaderboard);
      verify(() => mockRemoteDataSource.getWeeklyLeaderboard()).called(1);
    });
  });
}
