import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({
    required this.image,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDecoratedBox(
              padding: EdgeInsets.all(16.r),
              color: AppColors.surfaceLight,
              opacity: 0.2,
              borderRadius: BorderRadius.circular(32.r),
              child: Image.asset(
                image,
                height: 100.h,
                fit: BoxFit.contain,
              ),
            ),
            12.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                title,
                style: AppTextStyles.h4(context).copyWith(
                  color: AppColors.surfaceLight,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            8.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                subtitle,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.surfaceLight.withValues(alpha: 0.9),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
