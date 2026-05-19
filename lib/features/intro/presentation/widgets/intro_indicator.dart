import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class IntroIndicator extends StatelessWidget {
  const IntroIndicator({required this.currentIndex, super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: 8.h,
            width: currentIndex == index ? 24.w : 8.w,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.surfaceLight
                  : AppColors.surfaceLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      );
}
