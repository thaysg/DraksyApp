import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../presentation/models/feed_view_data.dart';

class StackProgress extends StatelessWidget {
  const StackProgress({
    required this.data,
    super.key,
  });

  final FeedWeeklyChallengeData data;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 65.r,
            height: 65.r,
            child: CircularProgressIndicator(
              value: data.progress,
              strokeWidth: 6.r,
              backgroundColor: AppColors.primaryAppColor.withValues(alpha: 0.1),
              color: AppColors.primaryAppColor,
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            '${data.completedLessons}/${data.totalLessons}',
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 13.sp,
            ),
          ),
        ],
      );
}
