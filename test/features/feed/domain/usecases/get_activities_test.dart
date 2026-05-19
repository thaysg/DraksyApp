import 'package:draksy/core/utils/models/pagination_request.dart';
import 'package:draksy/core/utils/models/pagination_response.dart';
import 'package:draksy/features/feed/data/models/feed_activity_model.dart';
import 'package:draksy/features/feed/domain/repositories/feed_repository.dart';
import 'package:draksy/features/feed/domain/usecases/get_activities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  late MockFeedRepository mockRepository;
  late GetActivities useCase;

  setUpAll(() {
    registerFallbackValue(const PaginationRequest(page: 1, limit: 10));
  });

  setUp(() {
    mockRepository = MockFeedRepository();
    useCase = GetActivities(mockRepository);
  });

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

  test('should get activities from the repository', () async {
    const tRequest = PaginationRequest(page: 1, limit: 10);
    when(() => mockRepository.getActivities(any())).thenAnswer(
      (_) async => StrautilsResponse.success(tPaginationResponse),
    );

    final result = await useCase(tRequest);

    expect(result.data, tPaginationResponse);
    verify(() => mockRepository.getActivities(tRequest)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
