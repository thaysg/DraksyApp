import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/spacing.dart';
import '../../../core/theme/app_colors.dart';

class MedalBadge extends StatelessWidget {
  const MedalBadge({required this.position, super.key});
  final int position;

  @override
  Widget build(BuildContext context) {
    final color = switch (position) {
      1 => AppColors.secondaryLight,
      2 => AppColors.mana,
      3 => AppColors.primaryAppColor,
      _ => AppColors.surfaceContainerHighest(context),
    };

    return SizedBox(
      width: 26.r,
      height: 32.r,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Ribbons
          Positioned(
            bottom: 4.r,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: -0.2,
                  child: SizedBox(
                    width: 7.w,
                    height: 14.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
                2.widthBox,
                Transform.rotate(
                  angle: 0.2,
                  child: SizedBox(
                    width: 7.w,
                    height: 14.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Circle
          SizedBox(
            width: 22.r,
            height: 22.r,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border:
                    Border.all(color: AppColors.backgroundLight, width: 2.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.backgroundDark.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                position.toString(),
                style: TextStyle(
                  color: AppColors.backgroundLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
