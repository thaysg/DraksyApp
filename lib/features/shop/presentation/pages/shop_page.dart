import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../providers/shop_provider.dart';
import '../views/shop_desktop_view.dart';
import '../views/shop_mobile_view.dart';
import '../views/shop_tablet_view.dart';
import '../widgets/shop_loading.dart';

class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopViewAsync = ref.watch(shopViewProvider);

    return Scaffold(
      body: SafeArea(
        child: shopViewAsync.when(
          data: (data) => ResponsiveLayoutBuilder(
            builder: (context, deviceType) => switch (deviceType) {
              DeviceType.mobile => ShopMobileView(data: data),
              DeviceType.tablet => ShopTabletView(data: data),
              DeviceType.desktop => ShopDesktopView(data: data),
            },
          ),
          loading: () => const ShopLoading(),
          error: (error, __) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(shopViewProvider),
          ),
        ),
      ),
    );
  }
}
