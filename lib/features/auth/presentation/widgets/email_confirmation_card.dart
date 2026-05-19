import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class EmailConfirmationCard extends StatelessWidget {
  const EmailConfirmationCard({
    required this.email,
    required this.onGoBackToSignIn,
    super.key,
  });

  final String email;
  final VoidCallback onGoBackToSignIn;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        color: AppColors.primaryDark,
        opacity: 0.3,
        borderRadius: BorderRadius.circular(28.r),
        padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 36.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mark_email_read_outlined,
              size: 56.r,
              color: AppColors.textPrimaryDark,
            ),
            24.heightBox,
            Text(
              context.l10n.checkYourEmail,
              style: AppTextStyles.titleMedium(context).copyWith(
                color: AppColors.textPrimaryDark,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            12.heightBox,
            Text(
              context.l10n.confirmationSentTo(email),
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            8.heightBox,
            Text(
              context.l10n.clickConfirmationLink,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
            ),
            32.heightBox,
            CustomButton(
              onPressed: onGoBackToSignIn,
              text: context.l10n.backToSignIn,
              width: double.infinity,
              height: 45.h,
            ),
          ],
        ),
      );
}
