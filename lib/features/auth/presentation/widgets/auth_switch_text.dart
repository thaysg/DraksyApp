import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/auth_providers.dart'; // Keep this for AuthType enum if it's there

class AuthSwitchText extends StatelessWidget {
  const AuthSwitchText({
    required this.authType,
    required this.onToggle,
    super.key,
  });

  final AuthType authType;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: onToggle,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: AppColors.textPrimaryDark.withValues(alpha: 0.8),
              fontSize: 14.sp,
            ),
            children: [
              TextSpan(
                text: authType == AuthType.login
                    ? l10n.dontHaveAccount
                    : l10n.alreadyHaveAccount,
              ),
              TextSpan(
                text: authType == AuthType.login ? l10n.signUp : l10n.signIn,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
