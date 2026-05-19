import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import 'row_level_and_progress.dart';
import 'row_time_and_lock_or_play.dart';

class LessonCategoryCard extends StatelessWidget {
  const LessonCategoryCard({
    required this.level,
    required this.title,
    required this.description,
    required this.progress,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    super.key,
    this.isLocked = false,
  });

  final int level;
  final String title;
  final String description;
  final double progress;
  final String time;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: CustomDecoratedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowLevelAndProgress(
                isLocked: isLocked,
                iconColor: iconColor,
                icon: icon,
                level: level,
                progress: progress,
              ),
              4.heightBox,
              Text(
                title,
                style: AppTextStyles.h4(context).copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              6.heightBox,
              Text(
                description,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
              24.heightBox,
              RowTimeAndLockOrPlay(
                time: time,
                isLocked: isLocked,
                iconColor: iconColor,
              ),
            ],
          ),
        ),
      );
}
