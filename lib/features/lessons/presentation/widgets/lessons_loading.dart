import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../models/lessons_view_data.dart';
import '../views/lessons/lessons_desktop_view.dart';
import '../views/lessons/lessons_mobile_view.dart';
import '../views/lessons/lessons_tablet_view.dart';

class LessonsLoading extends StatelessWidget {
  const LessonsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Skeletonizer(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) => switch (deviceType) {
            DeviceType.mobile => LessonsMobileView(data: LessonsViewData.mock),
            DeviceType.tablet => LessonsTabletView(data: LessonsViewData.mock),
            DeviceType.desktop =>
              LessonsDesktopView(data: LessonsViewData.mock),
          },
        ),
      );
}
