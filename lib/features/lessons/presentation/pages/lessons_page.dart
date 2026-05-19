import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../providers/lessons_provider.dart';
import '../views/lessons/lessons_desktop_view.dart';
import '../views/lessons/lessons_mobile_view.dart';
import '../views/lessons/lessons_tablet_view.dart';
import '../widgets/lessons_loading.dart';

class LessonsPage extends ConsumerWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsViewAsync = ref.watch(lessonsViewProvider);

    return Scaffold(
      body: SafeArea(
        child: lessonsViewAsync.when(
          data: (data) => ResponsiveLayoutBuilder(
            builder: (context, deviceType) => switch (deviceType) {
              DeviceType.mobile => LessonsMobileView(data: data),
              DeviceType.tablet => LessonsTabletView(data: data),
              DeviceType.desktop => LessonsDesktopView(data: data),
            },
          ),
          loading: () => const LessonsLoading(),
          error: (error, st) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(lessonsViewProvider),
          ),
        ),
      ),
    );
  }
}
