import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../models/edit_profile_view_data.dart';
import '../views/edit_profile_desktop_view.dart';
import '../views/edit_profile_mobile_view.dart';
import '../views/edit_profile_tablet_view.dart';

class EditProfileLoading extends StatelessWidget {
  const EditProfileLoading({super.key});

  @override
  Widget build(BuildContext context) => Skeletonizer(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24),
              child: Row(
                children: [
                  SizedBox(
                    width: 40.h,
                    height: 40.w,
                    child: CustomDecoratedBox(
                      borderRadius: BorderRadius.circular(12.r),
                      padding: const EdgeInsets.all(8),
                      child: const Center(
                        child: Icon(Icons.chevron_left_rounded),
                      ),
                    ),
                  ),
                  16.widthBox,
                  Text(context.l10n.editProfile),
                ],
              ),
            ),
            ResponsiveLayoutBuilder(
              builder: (context, deviceType) => switch (deviceType) {
                DeviceType.mobile => EditProfileMobileView(
                    data: EditProfileViewData.mock,
                    isSaving: false,
                    onSave: ({
                      required displayName,
                      required photoUrl,
                      required bio,
                    }) async {},
                  ),
                DeviceType.tablet => EditProfileTabletView(
                    data: EditProfileViewData.mock,
                    isSaving: false,
                    onSave: ({
                      required displayName,
                      required photoUrl,
                      required bio,
                    }) async {},
                  ),
                DeviceType.desktop => EditProfileDesktopView(
                    data: EditProfileViewData.mock,
                    isSaving: false,
                    onSave: ({
                      required displayName,
                      required photoUrl,
                      required bio,
                    }) async {},
                  ),
              },
            ),
          ],
        ),
      );
}
