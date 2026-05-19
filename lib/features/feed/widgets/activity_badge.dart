import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../presentation/models/feed_view_data.dart';

class ActivityBadge extends StatelessWidget {
  const ActivityBadge({
    required this.type,
    required this.value,
    super.key,
  });

  final FeedActivityType type;
  final String value;

  @override
  Widget build(BuildContext context) {
    final bgColor = switch (type) {
      FeedActivityType.lesson => AppColors.green.withValues(alpha: 0.1),
      FeedActivityType.level => AppColors.purple.withValues(alpha: 0.1),
      FeedActivityType.streak =>
        AppColors.secondaryLight.withValues(alpha: 0.1),
      FeedActivityType.achievement => AppColors.mana.withValues(alpha: 0.1),
    };

    return CustomDecoratedBox(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      opacity: 0.09,
      color: bgColor,
      borderRadius: BorderRadius.circular(12.r),
      child: switch (type) {
        FeedActivityType.lesson => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.stars_rounded, color: AppColors.green, size: 16.r),
              4.widthBox,
              Text(
                value,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        FeedActivityType.level => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium_rounded,
                  color: AppColors.purple, size: 16.r),
              2.heightBox,
              Text(
                value,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        FeedActivityType.streak => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department_rounded,
                  color: AppColors.secondaryLight, size: 16.r),
              2.heightBox,
              Text(
                value,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.secondaryLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        FeedActivityType.achievement => Icon(
            Icons.shield_rounded,
            color: AppColors.mana,
            size: 24.r,
          ),
      },
    );
  }
}
