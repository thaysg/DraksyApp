// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authView)
final authViewProvider = AuthViewProvider._();

final class AuthViewProvider
    extends $FunctionalProvider<AuthViewData, AuthViewData, AuthViewData>
    with $Provider<AuthViewData> {
  AuthViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authViewHash();

  @$internal
  @override
  $ProviderElement<AuthViewData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthViewData create(Ref ref) {
    return authView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthViewData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthViewData>(value),
    );
  }
}

String _$authViewHash() => r'3a9433e5304c1bfb507c51c8a8ccecfc02905367';

/// Provider for current auth page type

@ProviderFor(AuthTypeNotifier)
final authTypeProvider = AuthTypeNotifierProvider._();

/// Provider for current auth page type
final class AuthTypeNotifierProvider
    extends $NotifierProvider<AuthTypeNotifier, AuthType> {
  /// Provider for current auth page type
  AuthTypeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authTypeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authTypeNotifierHash();

  @$internal
  @override
  AuthTypeNotifier create() => AuthTypeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthType>(value),
    );
  }
}

String _$authTypeNotifierHash() => r'7dce31f0fa63a5a1a7ada39250fa55b5baf9939c';

/// Provider for current auth page type

abstract class _$AuthTypeNotifier extends $Notifier<AuthType> {
  AuthType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthType, AuthType>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AuthType, AuthType>, AuthType, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider extends $FunctionalProvider<
    AuthRemoteDataSource,
    AuthRemoteDataSource,
    AuthRemoteDataSource> with $Provider<AuthRemoteDataSource> {
  AuthRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'5b1ca13eaeacfcb684d74e0f647a1aa827e46c8a';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'ac79eada8d02d4bbccbbe578c76dabf2cdb26d36';

@ProviderFor(signInWithGoogleUseCase)
final signInWithGoogleUseCaseProvider = SignInWithGoogleUseCaseProvider._();

final class SignInWithGoogleUseCaseProvider extends $FunctionalProvider<
    SignInWithGoogle,
    SignInWithGoogle,
    SignInWithGoogle> with $Provider<SignInWithGoogle> {
  SignInWithGoogleUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'signInWithGoogleUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$signInWithGoogleUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInWithGoogle> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInWithGoogle create(Ref ref) {
    return signInWithGoogleUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithGoogle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithGoogle>(value),
    );
  }
}

String _$signInWithGoogleUseCaseHash() =>
    r'aa731494641de1e85e8b1fa8b962d14c9f83c8e5';

@ProviderFor(signInWithEmailUseCase)
final signInWithEmailUseCaseProvider = SignInWithEmailUseCaseProvider._();

final class SignInWithEmailUseCaseProvider extends $FunctionalProvider<
    SignInWithEmail,
    SignInWithEmail,
    SignInWithEmail> with $Provider<SignInWithEmail> {
  SignInWithEmailUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'signInWithEmailUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$signInWithEmailUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInWithEmail> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInWithEmail create(Ref ref) {
    return signInWithEmailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithEmail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithEmail>(value),
    );
  }
}

String _$signInWithEmailUseCaseHash() =>
    r'0017ecb0559cc915d8e0fc73e3be98cab8884dd0';

@ProviderFor(signUpWithEmailUseCase)
final signUpWithEmailUseCaseProvider = SignUpWithEmailUseCaseProvider._();

final class SignUpWithEmailUseCaseProvider extends $FunctionalProvider<
    SignUpWithEmail,
    SignUpWithEmail,
    SignUpWithEmail> with $Provider<SignUpWithEmail> {
  SignUpWithEmailUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'signUpWithEmailUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$signUpWithEmailUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignUpWithEmail> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignUpWithEmail create(Ref ref) {
    return signUpWithEmailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignUpWithEmail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignUpWithEmail>(value),
    );
  }
}

String _$signUpWithEmailUseCaseHash() =>
    r'366de64aab9796422abeef7451e66663dca6ba4d';

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $StreamNotifierProvider<Auth, User?> {
  AuthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'6f42e7f175acc37b7bbcf4da9dd7a45e398b2fa1';

abstract class _$Auth extends $StreamNotifier<User?> {
  Stream<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<User?>, User?>,
        AsyncValue<User?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for login loading state

@ProviderFor(AuthLoading)
final authLoadingProvider = AuthLoadingProvider._();

/// Provider for login loading state
final class AuthLoadingProvider extends $NotifierProvider<AuthLoading, bool> {
  /// Provider for login loading state
  AuthLoadingProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authLoadingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authLoadingHash();

  @$internal
  @override
  AuthLoading create() => AuthLoading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$authLoadingHash() => r'df12084e31f9d4cf771e219b5a5f2ca386891be6';

/// Provider for login loading state

abstract class _$AuthLoading extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

/// Tracks whether a confirmation e-mail was sent after signup.
/// Resets when the user switches auth mode or goes back.

@ProviderFor(EmailConfirmationSent)
final emailConfirmationSentProvider = EmailConfirmationSentProvider._();

/// Tracks whether a confirmation e-mail was sent after signup.
/// Resets when the user switches auth mode or goes back.
final class EmailConfirmationSentProvider
    extends $NotifierProvider<EmailConfirmationSent, bool> {
  /// Tracks whether a confirmation e-mail was sent after signup.
  /// Resets when the user switches auth mode or goes back.
  EmailConfirmationSentProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'emailConfirmationSentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$emailConfirmationSentHash();

  @$internal
  @override
  EmailConfirmationSent create() => EmailConfirmationSent();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$emailConfirmationSentHash() =>
    r'd5d953ea94f7a94189aca7dd23001e97a485fd7c';

/// Tracks whether a confirmation e-mail was sent after signup.
/// Resets when the user switches auth mode or goes back.

abstract class _$EmailConfirmationSent extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(PasswordVisibility)
final passwordVisibilityProvider = PasswordVisibilityProvider._();

final class PasswordVisibilityProvider
    extends $NotifierProvider<PasswordVisibility, bool> {
  PasswordVisibilityProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'passwordVisibilityProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$passwordVisibilityHash();

  @$internal
  @override
  PasswordVisibility create() => PasswordVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$passwordVisibilityHash() =>
    r'8a2d21ab7922dad28114fb011f130dbeafcee17a';

abstract class _$PasswordVisibility extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(emailController)
final emailControllerProvider = EmailControllerProvider._();

final class EmailControllerProvider extends $FunctionalProvider<
    TextEditingController,
    TextEditingController,
    TextEditingController> with $Provider<TextEditingController> {
  EmailControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'emailControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$emailControllerHash();

  @$internal
  @override
  $ProviderElement<TextEditingController> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextEditingController create(Ref ref) {
    return emailController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextEditingController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextEditingController>(value),
    );
  }
}

String _$emailControllerHash() => r'aca62e5be16d7ff3605079e301aa0dcd6d62b88e';

@ProviderFor(passwordController)
final passwordControllerProvider = PasswordControllerProvider._();

final class PasswordControllerProvider extends $FunctionalProvider<
    TextEditingController,
    TextEditingController,
    TextEditingController> with $Provider<TextEditingController> {
  PasswordControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'passwordControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$passwordControllerHash();

  @$internal
  @override
  $ProviderElement<TextEditingController> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextEditingController create(Ref ref) {
    return passwordController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextEditingController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextEditingController>(value),
    );
  }
}

String _$passwordControllerHash() =>
    r'6b0bba8f8d88e50437e77d1d79c9c77c00933d19';

@ProviderFor(nameController)
final nameControllerProvider = NameControllerProvider._();

final class NameControllerProvider extends $FunctionalProvider<
    TextEditingController,
    TextEditingController,
    TextEditingController> with $Provider<TextEditingController> {
  NameControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'nameControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$nameControllerHash();

  @$internal
  @override
  $ProviderElement<TextEditingController> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextEditingController create(Ref ref) {
    return nameController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextEditingController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextEditingController>(value),
    );
  }
}

String _$nameControllerHash() => r'3074666bb61fa41a3ef04cbd0885da0d51cee8e6';

@ProviderFor(confirmPasswordController)
final confirmPasswordControllerProvider = ConfirmPasswordControllerProvider._();

final class ConfirmPasswordControllerProvider extends $FunctionalProvider<
    TextEditingController,
    TextEditingController,
    TextEditingController> with $Provider<TextEditingController> {
  ConfirmPasswordControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'confirmPasswordControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$confirmPasswordControllerHash();

  @$internal
  @override
  $ProviderElement<TextEditingController> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextEditingController create(Ref ref) {
    return confirmPasswordController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextEditingController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextEditingController>(value),
    );
  }
}

String _$confirmPasswordControllerHash() =>
    r'377fe742849777986d1451c9e05c826ead8ce91b';
