import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class CardPlanWidget extends StatelessWidget {
  const CardPlanWidget({
    required this.isHighlighted,
    required this.title,
    required this.price,
    required this.period,
    required this.benefits,
    required this.onPressed,
    required this.buttonText,
    super.key,
  });

  final bool isHighlighted;
  final String title;
  final String price;
  final String period;
  final List<String> benefits;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: const EdgeInsets.all(16),
        gradient: isHighlighted
            ? (context.isDarkMode
                ? AppColors.darkGradient
                : AppColors.blueGradient)
            : null,
        color: isHighlighted
            ? null
            : (context.isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight)
                .withValues(alpha: 0.7),
        borderColor: isHighlighted
            ? AppColors.primaryAppColor.withValues(alpha: 0.5)
            : AppColors.primaryDark.withValues(alpha: 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.h4(context).copyWith(
                color: isHighlighted ? AppColors.textPrimaryDark : null,
                fontSize: 18,
              ),
            ),
            4.heightBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  price,
                  style: AppTextStyles.h2(context).copyWith(
                    color: isHighlighted ? AppColors.textPrimaryDark : null,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
                4.widthBox,
                Text(
                  period,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: isHighlighted
                        ? AppColors.textPrimaryDark.withValues(alpha: 0.7)
                        : AppColors.textSecondary(context),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            16.heightBox,
            ...benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: isHighlighted
                            ? AppColors.gold
                            : AppColors.primaryAppColor,
                        size: 16,
                      ),
                      8.widthBox,
                      Expanded(
                        child: Text(
                          benefit,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: isHighlighted
                                ? AppColors.textPrimaryDark
                                : null,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(child: 16.heightBox),
            CustomButton(
              onPressed: onPressed,
              text: buttonText,
              height: 50,
              type: isHighlighted ? ButtonType.elevated : ButtonType.outlined,
              textColor: isHighlighted
                  ? AppColors.textPrimaryDark
                  : AppColors.primaryAppColor,
              outlineStyle: !isHighlighted
                  ? OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: AppColors.primaryAppColor, width: 2),
                      foregroundColor: AppColors.primaryAppColor,
                      backgroundColor: AppColors.textPrimaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      );
}
