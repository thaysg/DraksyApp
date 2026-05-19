import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({required this.onTap, this.text, super.key});
  final VoidCallback? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.horizontalPadding, vertical: 24),
          child: CustomButton(
            text: (text ?? context.l10n.submit).toUpperCase(),
            onPressed: onTap,
            width: double.infinity,
          ),
        ),
      );
}
