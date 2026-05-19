import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../../../core/utils/pagination/paginated_list_view.dart';
import '../../../../core/utils/pagination/paginated_state.dart';
import '../presentation/models/feed_view_data.dart';
import '../presentation/providers/feed_activities_provider.dart';
import '../widgets/activity_item_card.dart';
import '../widgets/feed_header.dart';
import '../widgets/story_section.dart';
import '../widgets/weekly_challenge_card.dart';
import '../widgets/weekly_ranking_section.dart';

class FeedDesktopView extends ConsumerWidget {
  const FeedDesktopView({
    required this.data,
    required this.activitiesState,
    super.key,
  });

  final FeedViewData data;
  final PaginatedState<FeedActivityData> activitiesState;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.maxContentWidth(context),
          ),
          child: PaginatedListView(
            items: activitiesState.items,
            isLoading: activitiesState.isLoading,
            isLoadingMore: activitiesState.isLoadingMore,
            hasMore: activitiesState.hasMore,
            onLoadMore: () =>
                ref.read(feedActivitiesProvider.notifier).loadMore(),
            onRefresh: () =>
                ref.read(feedActivitiesProvider.notifier).refresh(),
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
                32.heightBox,
                StorySection(stories: data.stories),
                40.heightBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          WeeklyChallengeCard(data: data.weeklyChallenge),
                        ],
                      ),
                    ),
                    40.widthBox,
                    Expanded(
                      flex: 1,
                      child: WeeklyRankingSection(rankings: data.rankings),
                    ),
                  ],
                ),
                32.heightBox,
              ],
            ),
            itemBuilder: (context, item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ActivityItemCard(data: item),
                  ),
                  40.widthBox,
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            footer: Column(
              children: [
                100.heightBox,
              ],
            ),
          ),
        ),
      );
}
