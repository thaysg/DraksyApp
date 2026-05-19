import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../models/home_view_data.dart';
import '../views/home_desktop_view.dart';
import '../views/home_mobile_view.dart';
import '../views/home_tablet_view.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Skeletonizer(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) => switch (deviceType) {
            DeviceType.mobile => HomeMobileView(data: HomeViewData.mock),
            DeviceType.tablet => HomeTabletView(data: HomeViewData.mock),
            DeviceType.desktop => HomeDesktopView(data: HomeViewData.mock),
          },
        ),
      );
}
