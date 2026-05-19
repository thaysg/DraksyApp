import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../models/home_view_data.dart';
import 'daily_challenge_progress_bar.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({
    required this.data,
    super.key,
  });

  final HomeDailyChallengeData data;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        gradient: context.isDarkMode
            ? AppColors.darkGradient
            : AppColors.blueGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomDecoratedBox(
                    color: AppColors.surfaceLight.withValues(alpha: 0.1),
                    child: Text(
                      data.subtitle,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.surfaceLight,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                CustomDecoratedBox(
                  color: AppColors.surfaceLight.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  child: const Icon(Icons.menu_book_rounded,
                      color: AppColors.surfaceLight),
                ),
              ],
            ),
            16.heightBox,
            Text(
              data.title,
              style: AppTextStyles.h3(context).copyWith(
                color: AppColors.surfaceLight,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
            24.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.progress,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.surfaceLight.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  context.l10n.lessonsCount(data.lessonsCompleted),
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.surfaceLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            12.heightBox,
            DailyChallengeProgressBar(progress: data.progress),
            24.heightBox,
            CustomButton(
              text: context.l10n.startChallenge,
              onPressed: () {},
              width: double.infinity,
            ),
          ],
        ),
      );
}
