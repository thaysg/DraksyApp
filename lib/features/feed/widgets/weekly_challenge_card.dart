import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../../../core/constants/app_icons.dart';
import '../presentation/models/feed_view_data.dart';
import 'stacked_progress.dart';
import 'weekly_challenge_body.dart';

class WeeklyChallengeCard extends StatelessWidget {
  const WeeklyChallengeCard({required this.data, super.key});

  final FeedWeeklyChallengeData data;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        color: AppColors.primaryAppColor.withValues(alpha: 0.1),
        opacity: 0.09,
        borderColor: AppColors.primaryAppColor.withValues(alpha: 0.1),
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 12.h),
        child: Row(
          children: [
            Image.asset(
              AppIcons.trophy,
              width: 50.r,
              height: 50.r,
              errorBuilder: (_, __, ___) => Icon(
                Icons.emoji_events_rounded,
                color: AppColors.secondaryLight,
                size: 50.r,
              ),
            ),
            12.widthBox,
            Expanded(
              child: WeeklyChallengeBody(data: data),
            ),
            16.widthBox,
            StackProgress(data: data),
          ],
        ),
      );
}
