import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/responsive/responsive_layout.dart';
import '../../../core/utils/pagination/paginated_state.dart';
import '../presentation/models/feed_view_data.dart';
import '../views/feed_desktop_view.dart';
import '../views/feed_mobile_view.dart';
import '../views/feed_tablet_view.dart';

class FeedLoading extends StatelessWidget {
  const FeedLoading({super.key});

  @override
  Widget build(BuildContext context) => Skeletonizer(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) => switch (deviceType) {
            DeviceType.mobile => FeedMobileView(
                data: FeedViewData.mock,
                activitiesState:
                    PaginatedState<FeedActivityData>.initial().copyWith(
                  items: FeedViewData.mockActivities,
                ),
              ),
            DeviceType.tablet => FeedTabletView(
                data: FeedViewData.mock,
                activitiesState:
                    PaginatedState<FeedActivityData>.initial().copyWith(
                  items: FeedViewData.mockActivities,
                ),
              ),
            DeviceType.desktop => FeedDesktopView(
                data: FeedViewData.mock,
                activitiesState:
                    PaginatedState<FeedActivityData>.initial().copyWith(
                  items: FeedViewData.mockActivities,
                ),
              ),
          },
        ),
      );
}
