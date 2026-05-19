import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class LessonPathTrailSegment extends StatelessWidget {
  const LessonPathTrailSegment({super.key});

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.textSecondaryLight,
        opacity: 0.35,
        child: SizedBox(
          width: 14.w,
          height: 8.h,
        ),
      );
}
