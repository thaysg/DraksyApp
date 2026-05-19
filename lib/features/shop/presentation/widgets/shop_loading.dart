import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../models/shop_view_data.dart';
import '../views/shop_desktop_view.dart';
import '../views/shop_mobile_view.dart';
import '../views/shop_tablet_view.dart';

class ShopLoading extends StatelessWidget {
  const ShopLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Skeletonizer(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) => switch (deviceType) {
            DeviceType.mobile => ShopMobileView(data: ShopViewData.mock),
            DeviceType.tablet => ShopTabletView(data: ShopViewData.mock),
            DeviceType.desktop => ShopDesktopView(data: ShopViewData.mock),
          },
        ),
      );
}
