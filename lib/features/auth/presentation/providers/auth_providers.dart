import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/providers/storage_providers.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/crash_service.dart';
import '../../../../core/services/push/fcm_token_remote_data_source.dart';
import '../../../../core/services/push/push_notification_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../models/auth_view_data.dart';

part 'auth_providers.g.dart';

// ===============================================
// VIEW DATA PROVIDER
// ===============================================

@riverpod
AuthViewData authView(Ref ref) {
  final authType = ref.watch(authTypeProvider);
  final isLoading = ref.watch(authLoadingProvider);
  final emailConfirmationSent = ref.watch(emailConfirmationSentProvider);

  return AuthViewData(
    authType: authType,
    isLoading: isLoading,
    emailConfirmationSent: emailConfirmationSent,
  );
}

// ===============================================
// UI STATE
// ===============================================

/// Enum for auth page type
enum AuthType { login, signup }

/// Provider for current auth page type
@riverpod
class AuthTypeNotifier extends _$AuthTypeNotifier {
  @override
  AuthType build() => AuthType.login;

  void toggle() {
    ref.read(emailConfirmationSentProvider.notifier).reset();
    state = state == AuthType.login ? AuthType.signup : AuthType.login;
  }

  AuthType get authType => state;
  set authType(AuthType type) => state = type;
}

// ===============================================
// DATA SOURCES & REPOSITORIES
// ===============================================

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) =>
    AuthRemoteDataSourceImpl();

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
      ref.watch(authRemoteDataSourceProvider),
      ref.watch(localDataBaseProvider),
      ref.watch(storageServiceProvider),
    );

// ===============================================
// USE CASES
// ===============================================

@riverpod
SignInWithGoogle signInWithGoogleUseCase(Ref ref) =>
    SignInWithGoogle(ref.watch(authRepositoryProvider));

@riverpod
SignInWithEmail signInWithEmailUseCase(Ref ref) =>
    SignInWithEmail(ref.watch(authRepositoryProvider));

@riverpod
SignUpWithEmail signUpWithEmailUseCase(Ref ref) =>
    SignUpWithEmail(ref.watch(authRepositoryProvider));

// ===============================================
// NOTIFIERS (STATE)
// ===============================================

@riverpod
class Auth extends _$Auth {
  @override
  Stream<User?> build() => ref.watch(authRepositoryProvider).userChanges;

  Future<void> _onSuccessfulLogin(User user) async {
    await ref.read(analyticsServiceProvider).setUserId(user.id);
    await ref.read(crashServiceProvider).setUserId(user.id);

    final pushService = ref.read(pushNotificationServiceProvider);
    await pushService.initialize();
    final token = await pushService.getToken();
    if (token != null) {
      await ref.read(fcmTokenRemoteDataSourceProvider).upsertToken(
            user.id,
            token,
          );
    }

    // Listen for token refresh and update in database
    final sub = pushService.onTokenRefresh.listen((newToken) {
      ref.read(fcmTokenRemoteDataSourceProvider).upsertToken(user.id, newToken);
    });
    ref.onDispose(sub.cancel);
  }

  Future<User?> signInWithGoogle() async {
    ref.read(authLoadingProvider.notifier).isLoading = true;
    try {
      final response = await ref.read(signInWithGoogleUseCaseProvider)();
      if (response.error) {
        throw response.data as AppException? ??
            AuthException(message: response.message);
      }

      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      if (user != null) {
        await _onSuccessfulLogin(user);
      }
      return user;
    } finally {
      ref.read(authLoadingProvider.notifier).isLoading = false;
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    ref.read(authLoadingProvider.notifier).isLoading = true;
    try {
      final response =
          await ref.read(signInWithEmailUseCaseProvider)(email, password);

      if (response.error) {
        throw response.data as AppException? ??
            AuthException(message: response.message);
      }

      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      if (user != null) {
        await _onSuccessfulLogin(user);
      }
      return user;
    } finally {
      ref.read(authLoadingProvider.notifier).isLoading = false;
    }
  }

  Future<User?> signUpWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    ref.read(authLoadingProvider.notifier).isLoading = true;
    try {
      final response = await ref.read(signUpWithEmailUseCaseProvider)(
        email,
        password,
        displayName,
      );

      if (response.error) {
        throw response.data as AppException? ??
            AuthException(message: response.message);
      }

      // Supabase email confirmation flow: the user is created but not
      // authenticated until they confirm their email.
      ref.read(emailConfirmationSentProvider.notifier).markSent();
      return response.data;
    } finally {
      ref.read(authLoadingProvider.notifier).isLoading = false;
    }
  }

  Future<void> onLoginPressed(BuildContext context) async {
    final l10n = context.l10n;
    try {
      final email = ref.read(emailControllerProvider).text.trim();
      final password = ref.read(passwordControllerProvider).text.trim();

      if (email.isEmpty || password.isEmpty) {
        return;
      }

      final user = await signInWithEmail(email, password);

      if (context.mounted && user != null) {
        context.showSuccessSnackBar(
          l10n.welcomeUser(user.displayName ?? user.email),
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(e.toString());
      }
    }
  }

  Future<void> onSignUpPressed(BuildContext context) async {
    try {
      final email = ref.read(emailControllerProvider).text.trim();
      final password = ref.read(passwordControllerProvider).text.trim();
      final confirmPassword =
          ref.read(confirmPasswordControllerProvider).text.trim();
      final name = ref.read(nameControllerProvider).text.trim();

      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return;
      }

      if (password != confirmPassword) {
        throw const MismatchException();
      }

      await signUpWithEmail(email, password, name);
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(e.toString());
      }
    }
  }

  Future<void> onGoogleSignInPressed(BuildContext context) async {
    final l10n = context.l10n;
    try {
      final user = await signInWithGoogle();
      if (context.mounted && user != null) {
        context.showSuccessSnackBar(
          l10n.welcomeUser(user.displayName ?? user.email),
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(e.toString());
      }
    }
  }

  Future<void> logout() async {
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    if (user != null) {
      final token = await ref.read(pushNotificationServiceProvider).getToken();
      if (token != null) {
        await ref.read(fcmTokenRemoteDataSourceProvider).deleteToken(
              user.id,
              token,
            );
      }
    }

    final response = await ref.read(authRepositoryProvider).signOut();
    if (response.error) {
      throw response.data as AppException? ??
          AuthException(message: response.message);
    }
  }

  Future<void> deleteAccount() async {
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    if (user != null) {
      final token = await ref.read(pushNotificationServiceProvider).getToken();
      if (token != null) {
        await ref.read(fcmTokenRemoteDataSourceProvider).deleteToken(
              user.id,
              token,
            );
      }
    }

    final response = await ref.read(authRepositoryProvider).deleteAccount();
    if (response.error) {
      throw response.data as AppException? ??
          AuthException(message: response.message);
    }
  }

  Future<void> updateProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  }) async {
    ref.read(authLoadingProvider.notifier).isLoading = true;
    try {
      final response = await ref.read(authRepositoryProvider).updateProfile(
            displayName: displayName,
            photoUrl: photoUrl,
            bio: bio,
          );

      if (response.error) {
        throw response.data as AppException? ??
            AuthException(message: response.message);
      }
    } finally {
      ref.read(authLoadingProvider.notifier).isLoading = false;
    }
  }
}

/// Provider for login loading state
@riverpod
class AuthLoading extends _$AuthLoading {
  @override
  bool build() => false;

  set isLoading(bool value) => state = value;
  bool get isLoading => state;
}

/// Tracks whether a confirmation e-mail was sent after signup.
/// Resets when the user switches auth mode or goes back.
@riverpod
class EmailConfirmationSent extends _$EmailConfirmationSent {
  @override
  bool build() => false;

  void markSent() => state = true;
  void reset() => state = false;
}

@riverpod
class PasswordVisibility extends _$PasswordVisibility {
  @override
  bool build() => true;

  void toggle() => state = !state;
}

@riverpod
TextEditingController emailController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
TextEditingController passwordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
TextEditingController nameController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
TextEditingController confirmPasswordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
}
