import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class LessonPathAppBar extends StatelessWidget {
  const LessonPathAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.chevron_left_rounded, size: 30.sp),
              color: AppColors.textPrimary(context),
            ),
            8.widthBox,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.titleLarge(context),
              ),
            ),
            CustomDecoratedBox(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              color: AppColors.surfaceLight,
              opacity: 1,
              borderColor: AppColors.primaryAppColor,
              borderRadius: BorderRadius.circular(20.r),
              child: Row(
                children: [
                  Icon(Icons.favorite_rounded,
                      color: AppColors.hp, size: 18.sp),
                  8.widthBox,
                  Text(
                    context.l10n.livesFull,
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      color: AppColors.primaryAppColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
