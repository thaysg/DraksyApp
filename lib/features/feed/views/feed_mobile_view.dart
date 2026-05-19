import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/utils/pagination/paginated_list_view.dart';
import '../../../../core/utils/pagination/paginated_state.dart';
import '../presentation/models/feed_view_data.dart';
import '../presentation/providers/feed_activities_provider.dart';
import '../widgets/activity_item_card.dart';
import '../widgets/feed_header.dart';
import '../widgets/story_section.dart';
import '../widgets/weekly_challenge_card.dart';
import '../widgets/weekly_ranking_section.dart';

class FeedMobileView extends ConsumerWidget {
  const FeedMobileView({
    required this.data,
    required this.activitiesState,
    super.key,
  });

  final FeedViewData data;
  final PaginatedState<FeedActivityData> activitiesState;

  @override
  Widget build(BuildContext context, WidgetRef ref) => PaginatedListView(
        items: activitiesState.items,
        isLoading: activitiesState.isLoading,
        isLoadingMore: activitiesState.isLoadingMore,
        hasMore: activitiesState.hasMore,
        onLoadMore: () => ref.read(feedActivitiesProvider.notifier).loadMore(),
        onRefresh: () => ref.read(feedActivitiesProvider.notifier).refresh(),
        initialError: activitiesState.initialError,
        paginationError: activitiesState.paginationError,
        onRetryInitial: () =>
            ref.read(feedActivitiesProvider.notifier).loadInitial(),
        onRetryPagination: () =>
            ref.read(feedActivitiesProvider.notifier).loadMore(),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FeedHeader(),
            20.heightBox,
            StorySection(stories: data.stories),
            WeeklyChallengeCard(data: data.weeklyChallenge),
            24.heightBox,
          ],
        ),
        footer: Column(
          children: [
            32.heightBox,
            WeeklyRankingSection(rankings: data.rankings),
            100.heightBox,
          ],
        ),
        itemBuilder: (context, item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ActivityItemCard(data: item),
        ),
      );
}
