import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Heart/lives indicator widget for displaying remaining lives.
/// Shows filled and empty hearts based on current lives.
class HeartLivesIndicator extends StatelessWidget {
  /// Creates a heart lives indicator
  const HeartLivesIndicator({
    required this.currentLives,
    required this.maxLives,
    super.key,
    this.size = 24,
    this.spacing = 4,
  });

  /// Current number of lives
  final int currentLives;

  /// Maximum number of lives
  final int maxLives;

  /// Heart size
  final double size;

  /// Spacing between hearts
  final double spacing;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          maxLives,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: Icon(
              index < currentLives ? Icons.favorite : Icons.favorite_border,
              color: AppColors.hp,
              size: size,
            ),
          ),
        ),
      );
}
