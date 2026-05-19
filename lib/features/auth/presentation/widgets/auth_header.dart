import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/auth_providers.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.authType,
    super.key,
  });

  final AuthType authType;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Image.asset(
          AppImages.logo,
          height: 80.h,
          fit: BoxFit.contain,
        ),
        8.heightBox,
        Text(
          authType == AuthType.login ? l10n.welcomeBack : l10n.createAccount,
          style: AppTextStyles.h1(context).copyWith(
            color: AppColors.textPrimaryDark,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        2.heightBox,
        Text(
          authType == AuthType.login
              ? l10n.signInToContinue
              : l10n.joinUsToStart,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: AppColors.textPrimaryDark.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
