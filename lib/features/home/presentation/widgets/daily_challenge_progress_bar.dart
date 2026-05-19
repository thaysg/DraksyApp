import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DailyChallengeProgressBar extends StatelessWidget {
  const DailyChallengeProgressBar({
    required this.progress,
    super.key,
  });
  final double progress;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 8,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceLight.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      );
}
