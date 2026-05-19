import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../presentation/models/feed_view_data.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({required this.data, super.key});

  final FeedStoryData data;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Stack(
            children: [
              UserAvatar(
                photoUrl: data.photoUrl,
                radius: 35,
                borderWidth: 2.r,
                borderColor: data.hasUpdate
                    ? AppColors.primaryAppColor
                    : AppColors.surfaceContainerHighest(context),
              ),
              if (data.isOnline)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 14.r,
                    height: 14.r,
                    decoration: BoxDecoration(
                      color: data.isMe
                          ? AppColors.primaryAppColor
                          : AppColors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.background(context),
                        width: 2.r,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          8.heightBox,
          Text(
            data.name,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      );
}
