import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';

class ShopCounterButton extends StatelessWidget {
  const ShopCounterButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: CustomDecoratedBox(
          padding: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(10),
          child: Icon(
            icon,
            color: AppColors.textSecondary(context),
            size: 20,
          ),
        ),
      );
}
