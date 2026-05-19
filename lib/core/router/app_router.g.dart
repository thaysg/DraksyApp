// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authListenable)
final authListenableProvider = AuthListenableProvider._();

final class AuthListenableProvider extends $FunctionalProvider<
    ValueNotifier<User?>,
    ValueNotifier<User?>,
    ValueNotifier<User?>> with $Provider<ValueNotifier<User?>> {
  AuthListenableProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authListenableProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authListenableHash();

  @$internal
  @override
  $ProviderElement<ValueNotifier<User?>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ValueNotifier<User?> create(Ref ref) {
    return authListenable(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ValueNotifier<User?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ValueNotifier<User?>>(value),
    );
  }
}

String _$authListenableHash() => r'1407027043b69dbc146aecea69f149511265e5d3';

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  AppRouterProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appRouterProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'6646a62f5aa67aec9c3274dc62359244c223d04d';
