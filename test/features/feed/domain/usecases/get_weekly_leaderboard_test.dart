import 'package:draksy/features/feed/data/models/feed_ranking_model.dart';
import 'package:draksy/features/feed/domain/repositories/feed_repository.dart';
import 'package:draksy/features/feed/domain/usecases/get_weekly_leaderboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  late MockFeedRepository mockRepository;
  late GetWeeklyLeaderboard useCase;

  setUp(() {
    mockRepository = MockFeedRepository();
    useCase = GetWeeklyLeaderboard(mockRepository);
  });

  final tLeaderboard = [
    const FeedRankingModel(
      userId: '1',
      userName: 'User',
      userPhotoUrl: '',
      xp: '100',
      position: 1,
    ),
  ];

  test('should get weekly leaderboard from the repository', () async {
    when(() => mockRepository.getWeeklyLeaderboard())
        .thenAnswer((_) async => StrautilsResponse.success(tLeaderboard));

    final result = await useCase();

    expect(result.data, tLeaderboard);
    verify(() => mockRepository.getWeeklyLeaderboard()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
