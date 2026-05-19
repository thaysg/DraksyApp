import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class RowLevelAndProgress extends StatelessWidget {
  const RowLevelAndProgress({
    required this.isLocked,
    required this.iconColor,
    required this.icon,
    required this.level,
    required this.progress,
    super.key,
  });

  final bool isLocked;
  final Color iconColor;
  final IconData icon;
  final int level;
  final double progress;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomDecoratedBox(
              opacity: 0.1,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              color: isLocked
                  ? AppColors.textSecondary(context).withValues(alpha: 0.1)
                  : iconColor.withValues(alpha: 0.1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon,
                      size: 14.r,
                      color: isLocked
                          ? AppColors.textSecondary(context)
                          : iconColor),
                  6.widthBox,
                  Flexible(
                    child: Text(
                      context.l10n.level(level).toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall(context).copyWith(
                        fontWeight: FontWeight.w900,
                        color: isLocked
                            ? AppColors.textSecondary(context)
                            : iconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.widthBox,
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 54.r,
                height: 54.r,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor:
                      AppColors.surface(context).withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      );
}
