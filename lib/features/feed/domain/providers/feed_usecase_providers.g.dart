// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getActivities)
final getActivitiesProvider = GetActivitiesProvider._();

final class GetActivitiesProvider
    extends $FunctionalProvider<GetActivities, GetActivities, GetActivities>
    with $Provider<GetActivities> {
  GetActivitiesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getActivitiesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getActivitiesHash();

  @$internal
  @override
  $ProviderElement<GetActivities> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetActivities create(Ref ref) {
    return getActivities(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetActivities value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetActivities>(value),
    );
  }
}

String _$getActivitiesHash() => r'6f9e08e5a840778c57b9b5ed458d3ca392702104';

@ProviderFor(getFriends)
final getFriendsProvider = GetFriendsProvider._();

final class GetFriendsProvider
    extends $FunctionalProvider<GetFriends, GetFriends, GetFriends>
    with $Provider<GetFriends> {
  GetFriendsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getFriendsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getFriendsHash();

  @$internal
  @override
  $ProviderElement<GetFriends> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetFriends create(Ref ref) {
    return getFriends(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetFriends value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetFriends>(value),
    );
  }
}

String _$getFriendsHash() => r'adfdf787ab4da6980f39a96766fc0a58b826f1a3';

@ProviderFor(getWeeklyChallenge)
final getWeeklyChallengeProvider = GetWeeklyChallengeProvider._();

final class GetWeeklyChallengeProvider extends $FunctionalProvider<
    GetWeeklyChallenge,
    GetWeeklyChallenge,
    GetWeeklyChallenge> with $Provider<GetWeeklyChallenge> {
  GetWeeklyChallengeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getWeeklyChallengeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getWeeklyChallengeHash();

  @$internal
  @override
  $ProviderElement<GetWeeklyChallenge> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetWeeklyChallenge create(Ref ref) {
    return getWeeklyChallenge(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWeeklyChallenge value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWeeklyChallenge>(value),
    );
  }
}

String _$getWeeklyChallengeHash() =>
    r'fcf91b107415dfa47970b90909b42271e37cdabd';

@ProviderFor(getWeeklyLeaderboard)
final getWeeklyLeaderboardProvider = GetWeeklyLeaderboardProvider._();

final class GetWeeklyLeaderboardProvider extends $FunctionalProvider<
    GetWeeklyLeaderboard,
    GetWeeklyLeaderboard,
    GetWeeklyLeaderboard> with $Provider<GetWeeklyLeaderboard> {
  GetWeeklyLeaderboardProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getWeeklyLeaderboardProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getWeeklyLeaderboardHash();

  @$internal
  @override
  $ProviderElement<GetWeeklyLeaderboard> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetWeeklyLeaderboard create(Ref ref) {
    return getWeeklyLeaderboard(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWeeklyLeaderboard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWeeklyLeaderboard>(value),
    );
  }
}

String _$getWeeklyLeaderboardHash() =>
    r'5564b2ce79c3fa7a6c0899b3ec132a0c72d84b05';
