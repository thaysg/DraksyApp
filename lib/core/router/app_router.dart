import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/home_navigation/page/home_navigation.dart';
import '../../features/intro/presentation/pages/intro_page.dart';
import '../../features/lessons/presentation/pages/lesson_page.dart';
import '../../features/lessons/presentation/pages/lessons_path_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../constants/app_routes.dart';

part 'app_router.g.dart';

@riverpod
ValueNotifier<User?> authListenable(Ref ref) {
  final notifier = ValueNotifier<User?>(ref.read(authProvider).value);
  ref.listen(authProvider, (previous, next) {
    notifier.value = next.value;
  });
  return notifier;
}

@riverpod
GoRouter appRouter(Ref ref) {
  final refreshListenable = ref.watch(authListenableProvider);

  return GoRouter(
    initialLocation: AppPaths.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      // Wait for auth state to be loaded before redirecting
      // This ensures splash screen is visible during initialization
      if (authState.isLoading) {
        return null;
      }

      final user = authState.asData?.value;
      final location = state.matchedLocation;

      // Check if the user is on an auth-related page
      final isAuthPath = location == AppPaths.welcome ||
          location == AppPaths.login ||
          location == AppPaths.intro ||
          location == AppPaths.splash;

      // If user is not logged in and not on an auth page, redirect to intro
      if (user == null) {
        return isAuthPath ? null : AppPaths.intro;
      }

      // If user is logged in and on an auth page, redirect to home
      if (isAuthPath) {
        return AppPaths.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppPaths.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppPaths.intro,
        name: AppRoutes.intro,
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: AppPaths.welcome,
        name: AppRoutes.welcome,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppPaths.login,
        name: AppRoutes.login,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppPaths.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomeNavigation(),
      ),
      GoRoute(
        path: AppPaths.lessonPath,
        name: AppRoutes.lessonPath,
        builder: (context, state) {
          final title = state.pathParameters['title'] ?? '';
          return LessonsPathPage(categoryTitle: title);
        },
      ),
      GoRoute(
        path: AppPaths.lessonDetail,
        name: AppRoutes.lessonDetail,
        builder: (context, state) {
          final unitId = state.pathParameters['unitId'] ?? '';
          final lessonId = state.pathParameters['lessonId'] ?? '';
          final title = state.pathParameters['title'] ?? '';
          return LessonPage(
            unitId: unitId,
            lessonId: lessonId,
            lessonTitle: title,
          );
        },
      ),
      GoRoute(
        path: AppPaths.editProfile,
        name: AppRoutes.editProfile,
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: AppPaths.settings,
        name: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
