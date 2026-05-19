import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'shop_counter_button.dart';

class CounterRow extends StatelessWidget {
  const CounterRow({
    required this.onDecrement,
    required this.counterValue,
    required this.onIncrement,
    required this.price,
    super.key,
  });

  final VoidCallback? onDecrement;
  final int counterValue;
  final VoidCallback? onIncrement;
  final String price;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          ShopCounterButton(
            icon: Icons.remove,
            onPressed: onDecrement,
          ),
          12.widthBox,
          Text(
            counterValue.toString(),
            style: AppTextStyles.h3(context).copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          12.widthBox,
          ShopCounterButton(
            icon: Icons.add,
            onPressed: onIncrement,
          ),
          const Spacer(),
          const Icon(Icons.stars_rounded, color: AppColors.gold, size: 20),
          4.widthBox,
          Text(
            price,
            style: AppTextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      );
}
