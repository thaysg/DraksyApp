import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/storage_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

part 'splash_provider.g.dart';

/// State for the Splash screen.
enum SplashState {
  /// App is initializing
  initializing,

  /// Navigate to Intro/Onboarding
  navigateToIntro,

  /// Navigate to Welcome/Login
  navigateToWelcome,

  /// Navigate to World Map (Home)
  navigateToHome,
}

/// Key for onboarding completion in SharedPreferences
const String kOnboardingCompletedKey = 'onboarding_completed';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  Future<SplashState> build() async {
    // Artificial delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 3));

    if (!ref.mounted) {
      return SplashState.initializing;
    }

    final prefs = ref.read(sharedPreferencesProvider);
    final onboardingCompleted = prefs.getBool(kOnboardingCompletedKey) ?? false;

    if (!onboardingCompleted) {
      return SplashState.navigateToIntro;
    }

    final authRepository = ref.read(authRepositoryProvider);
    final user = await authRepository.getCurrentUser();

    if (user != null) {
      return SplashState.navigateToHome;
    }

    // User requested that if not logged in, it should go to intro
    return SplashState.navigateToIntro;
  }

  Future<void> completeOnboarding() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(kOnboardingCompletedKey, true);
  }
}
