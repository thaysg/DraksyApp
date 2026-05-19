import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../providers/home_provider.dart';
import '../views/home_desktop_view.dart';
import '../views/home_mobile_view.dart';
import '../views/home_tablet_view.dart';
import '../widgets/home_loading.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewAsync = ref.watch(homeViewProvider);

    return Scaffold(
      body: SafeArea(
        child: homeViewAsync.when(
          data: (data) => CustomRefreshIndicator(
            onRefresh: () => ref.refresh(homeViewProvider.future),
            child: ResponsiveLayoutBuilder(
              builder: (context, deviceType) => switch (deviceType) {
                DeviceType.mobile => HomeMobileView(data: data),
                DeviceType.tablet => HomeTabletView(data: data),
                DeviceType.desktop => HomeDesktopView(data: data),
              },
            ),
          ),
          loading: () => const HomeLoading(),
          error: (error, st) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(homeViewProvider),
          ),
        ),
      ),
    );
  }
}
