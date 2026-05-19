import 'package:flutter/material.dart';

import '../providers/auth_providers.dart';
import 'email_confirmation_card.dart';
import 'form_content.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    required this.authType,
    required this.isLoading,
    required this.obscurePassword,
    required this.emailConfirmationSent,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.onSignIn,
    required this.onSignUp,
    required this.onSignInWithGoogle,
    required this.onTogglePasswordVisibility,
    required this.onGoBackToSignIn,
    super.key,
  });

  final AuthType authType;
  final bool isLoading;
  final bool obscurePassword;

  /// True after signup — Supabase sent a confirmation e-mail.
  final bool emailConfirmationSent;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onTogglePasswordVisibility;

  /// Called when the user taps "Back to sign in" from the confirmation screen.
  final VoidCallback onGoBackToSignIn;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: emailConfirmationSent
            ? EmailConfirmationCard(
                key: const ValueKey('confirmation'),
                email: emailController.text.trim(),
                onGoBackToSignIn: onGoBackToSignIn,
              )
            : FormContent(
                key: const ValueKey('form'),
                authType: authType,
                isLoading: isLoading,
                obscurePassword: obscurePassword,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                nameController: nameController,
                onSignIn: onSignIn,
                onSignUp: onSignUp,
                onSignInWithGoogle: onSignInWithGoogle,
                onTogglePasswordVisibility: onTogglePasswordVisibility,
              ),
      );
}
