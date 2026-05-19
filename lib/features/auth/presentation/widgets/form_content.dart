import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../providers/auth_providers.dart';
import 'auth_social_buttons.dart';

class FormContent extends StatelessWidget {
  const FormContent({
    required this.authType,
    required this.isLoading,
    required this.obscurePassword,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.onSignIn,
    required this.onSignUp,
    required this.onSignInWithGoogle,
    required this.onTogglePasswordVisibility,
    super.key,
  });

  final AuthType authType;
  final bool isLoading;
  final bool obscurePassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onTogglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomDecoratedBox(
      color: AppColors.primaryDark,
      opacity: 0.3,
      borderRadius: BorderRadius.circular(28.r),
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (authType == AuthType.signup) ...[
            Text(
              l10n.fullName,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textPrimaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            8.heightBox,
            AppTextFormField(
              controller: nameController,
              hintText: l10n.yourName,
              prefixIcon: const Icon(Icons.person_outline),
              useAuthStyles: true,
            ),
            20.heightBox,
          ],
          Text(
            l10n.email,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.heightBox,
          AppTextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: l10n.yourEmail,
            prefixIcon: const Icon(Icons.email_outlined),
            useAuthStyles: true,
          ),
          20.heightBox,
          Text(
            l10n.password,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.heightBox,
          AppTextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            hintText: authType == AuthType.login
                ? l10n.yourPassword
                : l10n.createPassword,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: onTogglePasswordVisibility,
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.backgroundLight,
              ),
            ),
            useAuthStyles: true,
          ),
          if (authType == AuthType.signup) ...[
            20.heightBox,
            Text(
              l10n.confirmPassword,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textPrimaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            8.heightBox,
            AppTextFormField(
              controller: confirmPasswordController,
              obscureText: obscurePassword,
              hintText: l10n.confirmPassword,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.backgroundLight,
                ),
              ),
              useAuthStyles: true,
            ),
          ],
          12.heightBox,
          if (authType == AuthType.login)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                l10n.forgotPassword,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          24.heightBox,
          CustomButton(
            onPressed: authType == AuthType.login ? onSignIn : onSignUp,
            text: authType == AuthType.login ? l10n.signIn : l10n.createAccount,
            isLoading: isLoading,
            width: double.infinity,
            height: 45.h,
          ),
          24.heightBox,
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  authType == AuthType.login
                      ? l10n.orContinueWith
                      : l10n.orSignUpWith,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: AppColors.textPrimaryDark.withValues(alpha: 0.5),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
          24.heightBox,
          AuthSocialButtons(
            onGoogleSignIn: onSignInWithGoogle,
          ),
          if (authType == AuthType.signup) ...[
            24.heightBox,
            Center(
              child: Text(
                l10n.byCreatingAccount(l10n.termsOfService, l10n.privacyPolicy),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
