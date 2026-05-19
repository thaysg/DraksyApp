import 'package:draksy/features/feed/presentation/models/feed_view_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeedStoryData', () {
    test('supports value equality', () {
      expect(
        const FeedStoryData(
          name: 'Name',
          photoUrl: 'url',
          isMe: true,
          isOnline: true,
          hasUpdate: true,
        ),
        equals(
          const FeedStoryData(
            name: 'Name',
            photoUrl: 'url',
            isMe: true,
            isOnline: true,
            hasUpdate: true,
          ),
        ),
      );
    });
  });

  group('FeedWeeklyChallengeData', () {
    test('supports value equality', () {
      expect(
        const FeedWeeklyChallengeData(
          title: 'Title',
          description: 'Desc',
          completedLessons: 10,
          totalLessons: 20,
          remainingTime: '1d',
        ),
        equals(
          const FeedWeeklyChallengeData(
            title: 'Title',
            description: 'Desc',
            completedLessons: 10,
            totalLessons: 20,
            remainingTime: '1d',
          ),
        ),
      );
    });

    test('progress returns correct value', () {
      const data = FeedWeeklyChallengeData(
        title: 'Title',
        description: 'Desc',
        completedLessons: 10,
        totalLessons: 20,
        remainingTime: '1d',
      );
      expect(data.progress, 0.5);
    });
  });

  group('FeedActivityData', () {
    test('supports value equality', () {
      expect(
        const FeedActivityData(
          id: '1',
          userName: 'Name',
          userPhotoUrl: 'url',
          type: FeedActivityType.lesson,
          description: 'Desc',
          timeAgo: '1h',
          likes: 10,
          value: '+50',
        ),
        equals(
          const FeedActivityData(
            id: '1',
            userName: 'Name',
            userPhotoUrl: 'url',
            type: FeedActivityType.lesson,
            description: 'Desc',
            timeAgo: '1h',
            likes: 10,
            value: '+50',
          ),
        ),
      );
    });
  });

  group('FeedRankingData', () {
    test('supports value equality', () {
      expect(
        const FeedRankingData(
          userId: '1',
          userName: 'Name',
          userPhotoUrl: 'url',
          xp: '100',
          position: 1,
          isMe: true,
        ),
        equals(
          const FeedRankingData(
            userId: '1',
            userName: 'Name',
            userPhotoUrl: 'url',
            xp: '100',
            position: 1,
            isMe: true,
          ),
        ),
      );
    });
  });

  group('FeedViewData', () {
    test('supports value equality', () {
      expect(
        FeedViewData.mock,
        equals(FeedViewData.mock),
      );
    });

    test('mock contains expected data', () {
      expect(FeedViewData.mock.stories, isNotEmpty);
      expect(FeedViewData.mock.rankings, isNotEmpty);
      expect(FeedViewData.mock.weeklyChallenge.title, 'Desafio Semanal');
    });
  });
}
