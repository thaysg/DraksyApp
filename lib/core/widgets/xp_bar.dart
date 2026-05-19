import 'package:flutter/material.dart';

import '../extensions/localization_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// XP progress bar widget for displaying experience points.
/// Shows progress with a gradient fill and XP text label.
class XpBar extends StatelessWidget {
  /// Creates an XP progress bar
  const XpBar({
    required this.currentXp,
    required this.maxXp,
    super.key,
    this.height = 12.0,
    this.showLabel = true,
    this.color = AppColors.info,
    this.gradient,
  });

  /// Current XP amount
  final int currentXp;

  /// Maximum XP for level
  final int maxXp;

  /// Bar height
  final double height;

  /// Show label text
  final bool showLabel;

  final Color color;

  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final progress = (currentXp / maxXp).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 6,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.textSecondaryDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: gradient, // AppColors.xpBarGradient,
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 4),
          Text(
            context.l10n.xpProgress(currentXp, maxXp),
            style: AppTextStyles.xpBarLabel(context),
          ),
        ],
      ],
    );
  }
}
