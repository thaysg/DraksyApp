import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../models/auth_view_data.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_switch_text.dart';

class AuthDesktopView extends StatelessWidget {
  const AuthDesktopView({
    required this.data,
    required this.obscurePassword,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.onSignInWithEmail,
    required this.onSignUpWithEmail,
    required this.onSignInWithGoogle,
    required this.onToggleAuthType,
    required this.onTogglePasswordVisibility,
    required this.onGoBackToSignIn,
    super.key,
  });

  final AuthViewData data;
  final bool obscurePassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final VoidCallback onSignInWithEmail;
  final VoidCallback onSignUpWithEmail;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onToggleAuthType;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onGoBackToSignIn;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppResponsive.maxContentWidth(context),
            ),
            child: Column(
              children: [
                AuthHeader(authType: data.authType),
                64.heightBox,
                AuthForm(
                  authType: data.authType,
                  isLoading: data.isLoading,
                  obscurePassword: obscurePassword,
                  emailConfirmationSent: data.emailConfirmationSent,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  nameController: nameController,
                  onSignIn: onSignInWithEmail,
                  onSignUp: onSignUpWithEmail,
                  onSignInWithGoogle: onSignInWithGoogle,
                  onTogglePasswordVisibility: onTogglePasswordVisibility,
                  onGoBackToSignIn: onGoBackToSignIn,
                ),
                48.heightBox,
                AuthSwitchText(
                  authType: data.authType,
                  onToggle: onToggleAuthType,
                ),
                100.heightBox,
              ],
            ),
          ),
        ),
      );
}
