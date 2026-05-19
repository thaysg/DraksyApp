import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/localization_extension.dart';
import '../../../core/extensions/spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../presentation/models/feed_view_data.dart';

class ActiveItemBody extends StatelessWidget {
  const ActiveItemBody(
      {required this.data, required this.activeTitle, super.key});
  final FeedActivityData data;
  final String activeTitle;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activeTitle,
            style: AppTextStyles.bodyMedium(context).copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
          4.heightBox,
          Text(
            data.description,
            style: AppTextStyles.bodyMedium(context).copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary(context),
              fontSize: 12.sp,
            ),
          ),
          2.heightBox,
          Row(
            children: [
              Text(
                context.l10n.timeAgo(data.timeAgo),
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                ),
              ),
              16.widthBox,
              Icon(
                data.isLiked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                size: 18.r,
                color: data.isLiked
                    ? AppColors.primaryAppColor
                    : AppColors.textSecondary(context),
              ),
              4.widthBox,
              Text(
                data.likes.toString(),
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      );
}
