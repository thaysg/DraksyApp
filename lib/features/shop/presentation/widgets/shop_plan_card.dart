import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import 'card_plan_widget.dart';

class ShopPlanCard extends StatelessWidget {
  const ShopPlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.benefits,
    required this.buttonText,
    required this.onPressed,
    super.key,
    this.isHighlighted = false,
    this.badgeText,
  });

  final String title;
  final String price;
  final String period;
  final List<String> benefits;
  final String buttonText;
  final VoidCallback onPressed;
  final bool isHighlighted;
  final String? badgeText;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          CardPlanWidget(
            isHighlighted: isHighlighted,
            title: title,
            price: price,
            period: period,
            benefits: benefits,
            onPressed: onPressed,
            buttonText: buttonText,
          ),
          if (badgeText != null)
            Positioned(
              top: -10,
              right: 0,
              child: CustomDecoratedBox(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: AppColors.gold,
                borderColor: AppColors.gold,
                opacity: 1,
                child: Text(
                  badgeText!,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: AppColors.backgroundDark,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
        ],
      );
}
