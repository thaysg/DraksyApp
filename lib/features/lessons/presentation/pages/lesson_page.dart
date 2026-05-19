import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../models/lesson_view_data.dart';
import '../providers/lesson_provider.dart';
import '../views/lesson_mobile_view.dart';

class LessonPage extends ConsumerWidget {
  const LessonPage({
    required this.unitId,
    required this.lessonId,
    required this.lessonTitle,
    super.key,
  });

  final String unitId;
  final String lessonId;
  final String lessonTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodesAsync = ref.watch(lessonNodesProvider(lessonId));
    final session = ref.watch(lessonSessionProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: nodesAsync.when(
          data: (nodes) {
            // Initialize session if it's the first build for this lesson
            if (session.totalNodes == 0 && nodes.isNotEmpty) {
              final questionCount =
                  nodes.where((n) => n.type == 'question').length;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref
                    .read(lessonSessionProvider.notifier)
                    .init(nodes.length, questionCount);
              });
            }

            final data = LessonViewData(
              unitId: unitId,
              lessonId: lessonId,
              lessonTitle: lessonTitle,
              nodes: nodes,
              session: session,
            );

            return ResponsiveLayoutBuilder(
              builder: (context, deviceType) => switch (deviceType) {
                DeviceType.mobile => LessonMobileView(data: data),
                DeviceType.tablet => LessonMobileView(data: data),
                DeviceType.desktop => LessonMobileView(data: data),
              },
            );
          },
          loading: () => const LoadingIndicator(),
          error: (error, st) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(lessonNodesProvider(lessonId)),
          ),
        ),
      ),
    );
  }
}
