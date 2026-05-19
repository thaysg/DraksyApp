import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../../views/feed_desktop_view.dart';
import '../../views/feed_mobile_view.dart';
import '../../views/feed_tablet_view.dart';
import '../../widgets/feed_loading.dart';
import '../providers/feed_activities_provider.dart';
import '../providers/feed_provider.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final feedViewAsync = ref.watch(feedViewProvider);
    final activitiesState = ref.watch(feedActivitiesProvider);

    return Scaffold(
      body: SafeArea(
        child: feedViewAsync.when(
          data: (data) => ResponsiveLayoutBuilder(
            builder: (context, deviceType) => switch (deviceType) {
              DeviceType.mobile => FeedMobileView(
                  data: data,
                  activitiesState: activitiesState,
                ),
              DeviceType.tablet => FeedTabletView(
                  data: data,
                  activitiesState: activitiesState,
                ),
              DeviceType.desktop => FeedDesktopView(
                  data: data,
                  activitiesState: activitiesState,
                ),
            },
          ),
          loading: FeedLoading.new,
          error: (error, st) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(feedViewProvider),
          ),
        ),
      ),
    );
  }
}
