import 'package:flutter/material.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';

class ShopStatPill extends StatelessWidget {
  const ShopStatPill({
    required this.icon,
    required this.iconColor,
    required this.value,
    super.key,
    this.valueColor,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        borderRadius: BorderRadius.circular(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
            6.widthBox,
            Text(
              value,
              style: AppTextStyles.bodyMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                color: valueColor ?? AppColors.textPrimary(context),
              ),
            ),
          ],
        ),
      );
}
