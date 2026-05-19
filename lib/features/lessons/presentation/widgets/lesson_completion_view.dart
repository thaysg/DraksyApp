import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_animations.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../models/lesson_view_data.dart';
import 'check_button.dart';

class LessonCompletionView extends StatelessWidget {
  const LessonCompletionView({
    required this.data,
    required this.onFinish,
    super.key,
  });

  final LessonViewData data;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final session = data.session;
    final accuracy = session.accuracy;
    final isSuccess = accuracy >= 0.8;

    final String animationAsset;
    if (accuracy >= 1.0) {
      animationAsset = AppAnimations.goldMedal;
    } else if (accuracy >= 0.8) {
      animationAsset = AppAnimations.silverMedal;
    } else {
      animationAsset = AppAnimations.gameOver;
    }

    return Scaffold(
      body: CustomScroll(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            60.heightBox,
            Lottie.asset(
              animationAsset,
              height: 250.h,
              repeat: isSuccess,
              errorBuilder: (context, error, stackTrace) => Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? AppColors.success : AppColors.hp,
                size: 120.r,
              ),
            ),
            32.heightBox,
            Text(
              isSuccess
                  ? context.l10n.lessonCompletedTitle
                  : context.l10n.lessonFailedTitle,
              style: AppTextStyles.h3(context).copyWith(
                color: isSuccess ? AppColors.success : AppColors.hp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                isSuccess
                    ? context.l10n.lessonCompletedMessage
                    : context.l10n.lessonFailedMessage,
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color: AppColors.textSecondary(context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            48.heightBox,
            _buildStatCard(
              context,
              label: context.l10n.accuracy,
              value: '${(accuracy * 100).toInt()}%',
              color: isSuccess ? AppColors.success : AppColors.hp,
            ),
            16.heightBox,
            _buildStatCard(
              context,
              label: context.l10n.xp,
              value: '+${session.totalXp}',
              color: AppColors.primaryAppColor,
            ),
            60.heightBox,
          ],
        ),
      ),
      bottomNavigationBar: CheckButton(
        text: isSuccess ? context.l10n.finish : context.l10n.tryAgain,
        onTap: onFinish,
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) =>
      Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium(context),
            ),
            Text(
              value,
              style: AppTextStyles.h4(context).copyWith(color: color),
            ),
          ],
        ),
      );
}
