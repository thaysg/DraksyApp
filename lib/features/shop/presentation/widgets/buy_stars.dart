import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class BuyStars extends StatelessWidget {
  const BuyStars({
    required this.price,
    required this.onPressed,
    required this.buttonText,
    super.key,
  });

  final String price;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.stars_rounded, color: AppColors.gold, size: 20),
          4.widthBox,
          Text(
            price,
            style: AppTextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const Spacer(),
          CustomButton(
            onPressed: onPressed,
            text: buttonText,
            width: 95,
            height: 50,
            type: ButtonType.outlined,
            outlineStyle: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.info, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            textColor: AppColors.info,
          ),
        ],
      );
}
