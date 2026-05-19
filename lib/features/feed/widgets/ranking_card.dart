import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../core/extensions/localization_extension.dart';
import '../presentation/models/feed_view_data.dart';
import 'medal_badge.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    required this.data,
    required this.height,
    super.key,
  });

  final FeedRankingData data;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bgColor = data.isMe
        ? AppColors.primaryAppColor.withValues(alpha: 0.1)
        : switch (data.position) {
            1 => AppColors.secondaryLight.withValues(alpha: 0.1),
            2 => AppColors.mana.withValues(alpha: 0.1),
            3 => AppColors.primaryAppColor.withValues(alpha: 0.1),
            _ => AppColors.surfaceContainerHighest(context),
          };

    final badgeColor = data.isMe
        ? AppColors.primaryAppColor
        : switch (data.position) {
            1 => AppColors.gold,
            2 => AppColors.silver,
            3 => AppColors.bronze,
            _ => AppColors.textSecondary(context),
          };

    return SizedBox(
      height: height,
      child: CustomDecoratedBox(
        color: bgColor,
        borderColor: badgeColor.withValues(alpha: 0.1),
        opacity: 0.2,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MedalBadge(position: data.position),
                    6.widthBox,
                    UserAvatar(
                      photoUrl: data.userPhotoUrl,
                      radius: 22,
                      borderWidth: 2.r,
                      borderColor: badgeColor,
                    ),
                  ],
                ),
              ),
              10.heightBox,
              Text(
                data.userName,
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              2.heightBox,
              Text(
                context.l10n.xpValue(data.xp),
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w800,
                  fontSize: 10.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
