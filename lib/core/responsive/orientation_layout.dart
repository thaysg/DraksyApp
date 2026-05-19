import 'package:flutter/material.dart';

/// Orientation layout widget that adapts to portrait/landscape orientation.
/// Shows different layouts for portrait and landscape orientations.
class OrientationLayout extends StatelessWidget {
  /// Creates an orientation layout widget
  const OrientationLayout({
    required this.portrait,
    required this.landscape,
    super.key,
  });

  /// Portrait orientation layout
  final Widget portrait;

  /// Landscape orientation layout
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.orientationOf(context) == Orientation.portrait) {
      return portrait;
    } else {
      return landscape;
    }
  }
}
