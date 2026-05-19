import 'package:flutter/material.dart';

import '../extensions/spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_decorated_box.dart';

class IconRow extends StatelessWidget {
  const IconRow(
      {required this.icon,
      required this.iconColor,
      required this.value,
      this.valueColor,
      super.key});
  final IconData? icon;
  final Color? iconColor;
  final String? value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        borderRadius: BorderRadius.circular(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
            2.widthBox,
            Text(
              value ?? '',
              style: AppTextStyles.labelSmall(context).copyWith(
                fontWeight: FontWeight.w900,
                color: valueColor ?? AppColors.textPrimary(context),
              ),
            ),
          ],
        ),
      );
}
