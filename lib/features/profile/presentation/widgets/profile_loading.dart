import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../models/profile_view_data.dart';
import '../views/profile_desktop_view.dart';
import '../views/profile_mobile_view.dart';
import '../views/profile_tablet_view.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Skeletonizer(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) => switch (deviceType) {
            DeviceType.mobile => ProfileMobileView(
                data: ProfileViewData.mock,
                onLogout: () {},
                onDeleteAccount: () {},
              ),
            DeviceType.tablet => ProfileTabletView(
                data: ProfileViewData.mock,
                onLogout: () {},
                onDeleteAccount: () {},
              ),
            DeviceType.desktop => ProfileDesktopView(
                data: ProfileViewData.mock,
                onLogout: () {},
                onDeleteAccount: () {},
              ),
          },
        ),
      );
}
