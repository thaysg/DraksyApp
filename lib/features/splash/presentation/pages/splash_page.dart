import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/splash_provider.dart';
import '../widgets/splash_body.dart';

/// Splash page showing branding and handling initial navigation.
class SplashPage extends ConsumerWidget {
  /// Creates the splash page
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to splash state changes to navigate
    ref.listen(splashProvider, (previous, next) {
      next.when(
        data: (state) {
          switch (state) {
            case SplashState.navigateToIntro:
              context.go(AppPaths.intro);
              break;
            case SplashState.navigateToWelcome:
              context.go(AppPaths.welcome);
              break;
            case SplashState.navigateToHome:
              context.go(AppPaths.home);
              break;
            default:
              break;
          }
        },
        error: (error, stack) {
          // In case of error, go to welcome screen as fallback
          context.go(AppPaths.welcome);
        },
        loading: () {},
      );
    });

    return const Scaffold(
      backgroundColor: AppColors.primaryAppColor,
      body: SplashBody(),
    );
  }
}
