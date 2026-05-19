import 'package:draksy/core/utils/models/pagination_request.dart';
import 'package:draksy/core/utils/models/pagination_response.dart';
import 'package:draksy/features/auth/domain/entities/user.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/presentation/providers/auth_providers.dart';
import 'package:draksy/features/feed/data/models/feed_activity_model.dart';
import 'package:draksy/features/feed/data/models/feed_friend_model.dart';
import 'package:draksy/features/feed/data/providers/feed_repository_providers.dart';
import 'package:draksy/features/feed/domain/repositories/feed_repository.dart';
import 'package:draksy/features/feed/presentation/providers/feed_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockFeedRepository mockFeedRepository;

  setUpAll(() {
    registerFallbackValue(const PaginationRequest(page: 1, limit: 10));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockFeedRepository = MockFeedRepository();

    // Default mock behavior for repository
    when(() => mockFeedRepository.getFriends())
        .thenAnswer((_) async => StrautilsResponse.success([]));
    when(() => mockFeedRepository.getWeeklyChallenge())
        .thenAnswer((_) async => StrautilsResponse.success(null));
    when(() => mockFeedRepository.getActivities(any())).thenAnswer((_) async =>
        StrautilsResponse.success(
            PaginationResponse<FeedActivityModel>.empty()));
    when(() => mockFeedRepository.getWeeklyLeaderboard())
        .thenAnswer((_) async => StrautilsResponse.success([]));
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        feedRepositoryProvider.overrideWithValue(mockFeedRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('feedViewProvider', () {
    test('provides FeedViewData with user photo when authenticated', () async {
      final tUser = User(
        id: '123',
        email: 'test@example.com',
        displayName: 'Test User',
        photoURL: 'https://example.com/photo.jpg',
        createdAt: DateTime(2024),
      );

      when(() => mockAuthRepository.userChanges)
          .thenAnswer((_) => Stream.value(tUser));
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => tUser);

      final container = makeContainer();

      // Add a listener to keep the provider alive
      final subscription = container.listen(feedViewProvider, (_, __) {});

      final result = await container.read(feedViewProvider.future);

      expect(result.stories.first.name, 'Test User');
      expect(result.stories.first.photoUrl, 'https://example.com/photo.jpg');
      expect(result.stories.length, 1);

      subscription.close();
    });

    test('uses default photo when user has no photoURL', () async {
      final tUser = User(
        id: '123',
        email: 'test@example.com',
        createdAt: DateTime(2024),
      );

      when(() => mockAuthRepository.userChanges)
          .thenAnswer((_) => Stream.value(tUser));
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => tUser);

      final container = makeContainer();
      final subscription = container.listen(feedViewProvider, (_, __) {});

      final result = await container.read(feedViewProvider.future);

      expect(result.stories.first.photoUrl, 'https://i.pravatar.cc/150?u=me');

      subscription.close();
    });

    test('maps repository data correctly to FeedViewData', () async {
      final tUser = User(
        id: '123',
        email: 'test@example.com',
        createdAt: DateTime(2024),
      );

      const tFriends = [
        FeedFriendModel(
          id: '1',
          name: 'Friend',
          photoUrl: 'photo',
          isMe: false,
          isOnline: true,
          hasUpdate: true,
          streak: 5,
        ),
      ];

      final tActivities = [
        FeedActivityModel(
          id: 'act1',
          userName: 'Friend',
          userPhotoUrl: 'photo',
          type: 'lesson',
          description: 'Did something',
          createdAt: DateTime.now(),
          likes: 10,
          value: '+50',
          isOnline: true,
          isLiked: false,
        ),
      ];

      final tPaginationResponse = PaginationResponse<FeedActivityModel>(
        items: tActivities,
        totalCount: 1,
        currentPage: 1,
        lastPage: 1,
      );

      when(() => mockAuthRepository.userChanges)
          .thenAnswer((_) => Stream.value(tUser));
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => tUser);
      when(() => mockFeedRepository.getFriends())
          .thenAnswer((_) async => StrautilsResponse.success(tFriends));
      when(() => mockFeedRepository.getActivities(any())).thenAnswer(
          (_) async => StrautilsResponse.success(tPaginationResponse));

      final container = makeContainer();
      final subscription = container.listen(feedViewProvider, (_, __) {});

      // We need to trigger the activities provider as well or just mock the
      // feedView behavior
      // The current feedView provider only uses getFriends, getWeeklyChallenge,
      // getWeeklyLeaderboard.
      // Wait, let's check feed_provider.dart again.

      final result = await container.read(feedViewProvider.future);

      expect(result.stories.length, 2);
      expect(result.stories[1].name, 'Friend');
      // result.activities does not exist in FeedViewData anymore, it's in a
      // separate provider.
      // Wait, FeedViewData in
      // lib/features/feed/presentation/models/feed_view_data.dart
      // does NOT have activities.

      subscription.close();
    });
  });
}
