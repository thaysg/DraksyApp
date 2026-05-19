import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ProgressStacked extends StatelessWidget {
  const ProgressStacked({
    required this.progress,
    super.key,
  });

  final double progress;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: 64.r,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6.r,
              backgroundColor: AppColors.success.withValues(alpha: 0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.success),
              strokeCap: StrokeCap.round,
            ),
          ),
          Icon(
            Icons.star_rounded,
            color: AppColors.secondaryLight,
            size: 24.sp,
          ),
        ],
      );
}
