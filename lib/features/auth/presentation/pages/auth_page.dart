import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_providers.dart';
import '../views/auth_desktop_view.dart';
import '../views/auth_mobile_view.dart';
import '../views/auth_tablet_view.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(authViewProvider);
    final obscurePassword = ref.watch(passwordVisibilityProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final confirmPasswordController =
        ref.watch(confirmPasswordControllerProvider);
    final nameController = ref.watch(nameControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryAppColor,
      body: SafeArea(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) {
            final views = (
              data: data,
              obscurePassword: obscurePassword,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              nameController: nameController,
              onSignInWithEmail: () =>
                  ref.read(authProvider.notifier).onLoginPressed(context),
              onSignUpWithEmail: () =>
                  ref.read(authProvider.notifier).onSignUpPressed(context),
              onSignInWithGoogle: () => ref
                  .read(authProvider.notifier)
                  .onGoogleSignInPressed(context),
              onToggleAuthType: () =>
                  ref.read(authTypeProvider.notifier).toggle(),
              onTogglePasswordVisibility: () =>
                  ref.read(passwordVisibilityProvider.notifier).toggle(),
              onGoBackToSignIn: () {
                ref.read(emailConfirmationSentProvider.notifier).reset();
                ref.read(authTypeProvider.notifier).authType = AuthType.login;
              },
            );

            return switch (deviceType) {
              DeviceType.mobile => AuthMobileView(
                  data: views.data,
                  obscurePassword: views.obscurePassword,
                  emailController: views.emailController,
                  passwordController: views.passwordController,
                  confirmPasswordController: views.confirmPasswordController,
                  nameController: views.nameController,
                  onSignInWithEmail: views.onSignInWithEmail,
                  onSignUpWithEmail: views.onSignUpWithEmail,
                  onSignInWithGoogle: views.onSignInWithGoogle,
                  onToggleAuthType: views.onToggleAuthType,
                  onTogglePasswordVisibility: views.onTogglePasswordVisibility,
                  onGoBackToSignIn: views.onGoBackToSignIn,
                ),
              DeviceType.tablet => AuthTabletView(
                  data: views.data,
                  obscurePassword: views.obscurePassword,
                  emailController: views.emailController,
                  passwordController: views.passwordController,
                  confirmPasswordController: views.confirmPasswordController,
                  nameController: views.nameController,
                  onSignInWithEmail: views.onSignInWithEmail,
                  onSignUpWithEmail: views.onSignUpWithEmail,
                  onSignInWithGoogle: views.onSignInWithGoogle,
                  onToggleAuthType: views.onToggleAuthType,
                  onTogglePasswordVisibility: views.onTogglePasswordVisibility,
                  onGoBackToSignIn: views.onGoBackToSignIn,
                ),
              DeviceType.desktop => AuthDesktopView(
                  data: views.data,
                  obscurePassword: views.obscurePassword,
                  emailController: views.emailController,
                  passwordController: views.passwordController,
                  confirmPasswordController: views.confirmPasswordController,
                  nameController: views.nameController,
                  onSignInWithEmail: views.onSignInWithEmail,
                  onSignUpWithEmail: views.onSignUpWithEmail,
                  onSignInWithGoogle: views.onSignInWithGoogle,
                  onToggleAuthType: views.onToggleAuthType,
                  onTogglePasswordVisibility: views.onTogglePasswordVisibility,
                  onGoBackToSignIn: views.onGoBackToSignIn,
                ),
            };
          },
        ),
      ),
    );
  }
}
