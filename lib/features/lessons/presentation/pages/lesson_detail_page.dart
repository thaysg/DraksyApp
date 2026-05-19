import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/lesson_detail_provider.dart';
import '../views/lesson_detail/lesson_detail_desktop_view.dart';
import '../views/lesson_detail/lesson_detail_mobile_view.dart';
import '../views/lesson_detail/lesson_detail_tablet_view.dart';
import '../widgets/app_bar_lessons_detail.dart';
import '../widgets/check_button.dart';

class LessonDetailPage extends ConsumerWidget {
  const LessonDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(lessonDetailViewProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.transparent,
        title: AppBarLessonsDetail(
          currentXp: data.currentXp,
          maxXp: data.maxXp,
          lives: data.lives,
        ),
      ),
      body: ResponsiveLayoutBuilder(
        builder: (context, deviceType) {
          switch (deviceType) {
            case DeviceType.mobile:
              return LessonDetailMobileView(data: data);
            case DeviceType.tablet:
              return LessonDetailTabletView(data: data);
            case DeviceType.desktop:
              return LessonDetailDesktopView(data: data);
          }
        },
      ),
      bottomNavigationBar: CheckButton(
        onTap: () {},
      ),
    );
  }
}
