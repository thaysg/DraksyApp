import 'package:flutter/material.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/widgets/xp_bar.dart';

class LessonProgressCard extends StatelessWidget {
  const LessonProgressCard({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.progress,
    required this.iconBgColor,
    this.width,
    super.key,
  });
  final String title;
  final String subtitle;
  final String emoji;
  final double progress;
  final Color iconBgColor;
  final double? width;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: CustomDecoratedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomDecoratedBox(
                    opacity: 0.1,
                    color: iconBgColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      emoji,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                  12.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.textSecondary(context),
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.heightBox,
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondary(context),
                ),
              ),
              8.heightBox,
              const XpBar(
                currentXp: 2,
                maxXp: 5,
              ),
              //     LessonProgressBar(progress: progress),
              16.heightBox,
              CustomButton(
                text: context.l10n.resume,
                onPressed: () {},
                type: ButtonType.outlined,
              )
              //ResumeButton(onTap: () {}),
            ],
          ),
        ),
      );
}
