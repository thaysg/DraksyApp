import 'package:flutter/material.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import 'buy_stars.dart';
import 'counter_row.dart';
import 'refil_widget.dart';

class ShopPowerUpItem extends StatelessWidget {
  const ShopPowerUpItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.price,
    required this.buttonText,
    required this.onPressed,
    super.key,
    this.showCounter = false,
    this.counterValue = 1,
    this.onIncrement,
    this.onDecrement,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String price;
  final String buttonText;
  final VoidCallback onPressed;
  final bool showCounter;
  final int counterValue;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RefilWidget(
              iconColor: iconColor,
              icon: icon,
              title: title,
              description: description,
            ),
            if (showCounter) ...[
              12.heightBox,
              CounterRow(
                onDecrement: onDecrement,
                counterValue: counterValue,
                onIncrement: onIncrement,
                price: price,
              ),
            ],
            Expanded(child: 12.heightBox),
            if (!showCounter)
              BuyStars(
                price: price,
                onPressed: onPressed,
                buttonText: buttonText,
              )
            else
              CustomButton(
                onPressed: onPressed,
                text: buttonText,
                height: 40,
              ),
          ],
        ),
      );
}
