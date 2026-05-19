import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LessonPathTrailPainter extends CustomPainter {
  const LessonPathTrailPainter({
    required this.animationValue,
    required this.nodePositions,
  });

  final double animationValue;
  final List<Offset> nodePositions;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodePositions.length < 2) {
      return;
    }

    final paint = Paint()
      ..color = AppColors.textSecondaryLight.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(nodePositions.first.dx, nodePositions.first.dy);

    for (var i = 0; i < nodePositions.length - 1; i++) {
      final p0 = nodePositions[i];
      final p1 = nodePositions[i + 1];

      // Create a smooth curve between nodes
      final controlPoint1 = Offset(p0.dx, (p0.dy + p1.dy) / 2);
      final controlPoint2 = Offset(p1.dx, (p0.dy + p1.dy) / 2);

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    final pathMetrics = path.computeMetrics();
    const dashWidth = 14.0;
    const dashHeight = 8.0;
    const dashSpacing = 10.0;
    const totalSpacing = dashWidth + dashSpacing;

    for (final metric in pathMetrics) {
      final startOffset = animationValue * totalSpacing;
      for (var distance = startOffset;
          distance < metric.length;
          distance += totalSpacing) {
        final tangent = metric.getTangentForOffset(distance);
        if (tangent != null) {
          final center = tangent.position;
          final angle = tangent.angle;

          canvas
            ..save()
            ..translate(center.dx, center.dy)
            ..rotate(-angle) // Rotate to align with path direction
            ..drawRRect(
              RRect.fromRectAndRadius(
                Rect.fromCenter(
                  center: Offset.zero,
                  width: dashWidth,
                  height: dashHeight,
                ),
                const Radius.circular(4),
              ),
              paint,
            )
            ..restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant LessonPathTrailPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue ||
      oldDelegate.nodePositions != nodePositions;
}
