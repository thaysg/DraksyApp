import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class IntroLoginText extends StatelessWidget {
  const IntroLoginText({
    super.key,
    this.visible = true,
  });

  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyMedium(context).copyWith(
          color: AppColors.surfaceLight.withValues(alpha: 0.8),
        ),
        children: [
          TextSpan(text: context.l10n.alreadyHaveAccount),
          TextSpan(
            text: context.l10n.logIn,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: AppColors.surfaceLight,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.push(AppPaths.login),
          ),
        ],
      ),
    );
  }
}
