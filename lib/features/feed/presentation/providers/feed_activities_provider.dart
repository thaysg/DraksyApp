import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/models/pagination_response.dart';
import '../../../../core/utils/pagination/paginated_notifier.dart';
import '../../../../core/utils/pagination/paginated_state.dart';
import '../../domain/providers/feed_usecase_providers.dart';
import '../models/feed_view_data.dart';

part 'feed_activities_provider.g.dart';

@riverpod
class FeedActivitiesNotifier extends _$FeedActivitiesNotifier
    with PaginatedNotifierMixin<FeedActivityData> {
  @override
  PaginatedState<FeedActivityData> build() {
    // Trigger initial load after the first frame
    Future.microtask(loadInitial);

    return PaginatedState<FeedActivityData>.initial().copyWith(isLoading: true);
  }

  @override
  PageFetcher<FeedActivityData> get fetchPage => (request) async {
        final getActivities = ref.read(getActivitiesProvider);
        final response = await getActivities(request);

        if (!response.error) {
          final paginatedResponse = response.data!;
          return PaginationResponse<FeedActivityData>(
            items: paginatedResponse.items.map((a) {
              final type = switch (a.type) {
                'lesson' => FeedActivityType.lesson,
                'level' => FeedActivityType.level,
                'streak' => FeedActivityType.streak,
                'achievement' => FeedActivityType.achievement,
                _ => FeedActivityType.lesson,
              };

              return FeedActivityData(
                id: a.id,
                userName: a.userName,
                userPhotoUrl: a.userPhotoUrl,
                type: type,
                description: a.description,
                timeAgo: '2h', // Should ideally be calculated
                likes: a.likes,
                value: a.value,
                isOnline: a.isOnline,
                isLiked: a.isLiked,
              );
            }).toList(),
            totalCount: paginatedResponse.totalCount,
            currentPage: paginatedResponse.currentPage,
            lastPage: paginatedResponse.lastPage,
          );
        } else {
          throw Exception(response.message);
        }
      };
}
