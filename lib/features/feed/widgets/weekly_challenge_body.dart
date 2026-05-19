import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../presentation/models/feed_view_data.dart';

class WeeklyChallengeBody extends StatelessWidget {
  const WeeklyChallengeBody({
    required this.data,
    super.key,
  });

  final FeedWeeklyChallengeData data;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  data.title,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 13.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              6.widthBox,
              Icon(
                Icons.access_time_rounded,
                color: AppColors.primaryAppColor,
                size: 14.r,
              ),
              2.widthBox,
              Text(
                data.remainingTime,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.primaryAppColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          4.heightBox,
          Text(
            data.description,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      );
}
