import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/xp_bar.dart';

class AppBarLessonsDetail extends StatelessWidget {
  const AppBarLessonsDetail({
    required this.currentXp,
    required this.maxXp,
    required this.lives,
    super.key,
  });

  final int currentXp;
  final int maxXp;
  final int lives;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: AppColors.textSecondary(context),
              size: 28.r,
            ),
            onPressed: () => context.pop(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: XpBar(
                currentXp: currentXp,
                maxXp: maxXp,
                showLabel: false,
                color: AppColors.primaryAppColor,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.favorite, color: AppColors.hp, size: 24.r),
              4.widthBox,
              Text(
                lives.toString(),
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.hp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      );
}
