import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../providers/lesson_path_provider.dart';
import '../views/lesson_path/lesson_path_desktop_view.dart';
import '../views/lesson_path/lesson_path_mobile_view.dart';
import '../views/lesson_path/lesson_path_tablet_view.dart';

class LessonsPathPage extends ConsumerWidget {
  const LessonsPathPage({
    required this.categoryTitle,
    super.key,
  });

  final String categoryTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(lessonsPathViewProvider(categoryTitle));

    return Scaffold(
      body: SafeArea(
        child: dataAsync.when(
          data: (data) {
            final unitsState = ref.watch(
              lessonPathUnitsProvider(data.levelName),
            );

            return ResponsiveLayoutBuilder(
              builder: (context, deviceType) => switch (deviceType) {
                DeviceType.mobile => LessonPathMobileView(
                    data: data,
                    unitsState: unitsState,
                  ),
                DeviceType.tablet => LessonPathTabletView(
                    data: data,
                    unitsState: unitsState,
                  ),
                DeviceType.desktop => LessonPathDesktopView(
                    data: data,
                    unitsState: unitsState,
                  ),
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
