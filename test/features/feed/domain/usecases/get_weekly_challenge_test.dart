import 'package:draksy/features/feed/data/models/feed_weekly_challenge_model.dart';
import 'package:draksy/features/feed/domain/repositories/feed_repository.dart';
import 'package:draksy/features/feed/domain/usecases/get_weekly_challenge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  late MockFeedRepository mockRepository;
  late GetWeeklyChallenge useCase;

  setUp(() {
    mockRepository = MockFeedRepository();
    useCase = GetWeeklyChallenge(mockRepository);
  });

  const tChallenge = FeedWeeklyChallengeModel(
    title: 'Title',
    description: 'Desc',
    completedLessons: 5,
    totalLessons: 10,
    remainingTime: '1d',
  );

  test('should get weekly challenge from the repository', () async {
    when(() => mockRepository.getWeeklyChallenge())
        .thenAnswer((_) async => StrautilsResponse.success(tChallenge));

    final result = await useCase();

    expect(result.data, tChallenge);
    verify(() => mockRepository.getWeeklyChallenge()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
