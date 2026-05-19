import 'package:draksy/features/feed/data/models/feed_friend_model.dart';
import 'package:draksy/features/feed/domain/repositories/feed_repository.dart';
import 'package:draksy/features/feed/domain/usecases/get_friends.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  late MockFeedRepository mockRepository;
  late GetFriends useCase;

  setUp(() {
    mockRepository = MockFeedRepository();
    useCase = GetFriends(mockRepository);
  });

  final tFriends = [
    const FeedFriendModel(
      id: '1',
      name: 'Friend',
      photoUrl: '',
      isMe: false,
      isOnline: true,
      hasUpdate: false,
      streak: 5,
    ),
  ];

  test('should get friends from the repository', () async {
    when(() => mockRepository.getFriends())
        .thenAnswer((_) async => StrautilsResponse.success(tFriends));

    final result = await useCase();

    expect(result.data, tFriends);
    verify(() => mockRepository.getFriends()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
