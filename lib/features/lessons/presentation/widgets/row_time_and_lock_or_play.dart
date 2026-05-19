import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class RowTimeAndLockOrPlay extends StatelessWidget {
  const RowTimeAndLockOrPlay({
    required this.time,
    required this.isLocked,
    required this.iconColor,
    super.key,
  });

  final String time;
  final bool isLocked;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 18.r,
                  color: AppColors.textSecondary(context),
                ),
                8.widthBox,
                Expanded(
                  child: Text(
                    time,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall(context).copyWith(
                      color: AppColors.textSecondary(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLocked)
            Flexible(
              child: CustomDecoratedBox(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                color: AppColors.surface(context).withValues(alpha: 0.1),
                opacity: 1,
                borderColor: AppColors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_rounded,
                        size: 16.r, color: AppColors.textSecondary(context)),
                    2.widthBox,
                    Flexible(
                      child: Text(
                        context.l10n.locked,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall(context).copyWith(
                          color: AppColors.textSecondary(context),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            CustomDecoratedBox(
              shape: BoxShape.circle,
              padding: const EdgeInsets.all(12),
              color: iconColor,
              opacity: 1,
              borderColor: AppColors.transparent,
              boxShadow: [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.surfaceLight,
                size: 28.r,
              ),
            ),
        ],
      );
}
