// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserStatsNotifier)
final userStatsProvider = UserStatsNotifierProvider._();

final class UserStatsNotifierProvider
    extends $NotifierProvider<UserStatsNotifier, UserStats> {
  UserStatsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userStatsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userStatsNotifierHash();

  @$internal
  @override
  UserStatsNotifier create() => UserStatsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserStats>(value),
    );
  }
}

String _$userStatsNotifierHash() => r'ff697b2b4231abd4acfd7548739f3a7aa9a44300';

abstract class _$UserStatsNotifier extends $Notifier<UserStats> {
  UserStats build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserStats, UserStats>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UserStats, UserStats>, UserStats, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
