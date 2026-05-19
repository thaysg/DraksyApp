import 'package:flutter/material.dart';

import 'lesson_path_trail_painter.dart';

class LessonPathTrail extends StatelessWidget {
  const LessonPathTrail({
    required this.nodePositions,
    required this.canvasSize,
    super.key,
  });

  final List<Offset> nodePositions;
  final Size canvasSize;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1500),
        builder: (context, value, child) => CustomPaint(
          size: canvasSize,
          painter: LessonPathTrailPainter(
            animationValue: value,
            nodePositions: nodePositions,
          ),
        ),
        onEnd: () {
          // No end, repeat logic would be needed here if end was finite.
          // For continuous animation, TweenAnimationBuilder might not be the
          // best replacement for a repeating controller.
        },
      );
}
