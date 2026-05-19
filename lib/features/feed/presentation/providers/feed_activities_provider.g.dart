// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_activities_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedActivitiesNotifier)
final feedActivitiesProvider = FeedActivitiesNotifierProvider._();

final class FeedActivitiesNotifierProvider extends $NotifierProvider<
    FeedActivitiesNotifier, PaginatedState<FeedActivityData>> {
  FeedActivitiesNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedActivitiesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedActivitiesNotifierHash();

  @$internal
  @override
  FeedActivitiesNotifier create() => FeedActivitiesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginatedState<FeedActivityData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PaginatedState<FeedActivityData>>(value),
    );
  }
}

String _$feedActivitiesNotifierHash() =>
    r'd3a6484ab9eafb771974e77bae171571a1e6ecb7';

abstract class _$FeedActivitiesNotifier
    extends $Notifier<PaginatedState<FeedActivityData>> {
  PaginatedState<FeedActivityData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PaginatedState<FeedActivityData>,
        PaginatedState<FeedActivityData>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PaginatedState<FeedActivityData>,
            PaginatedState<FeedActivityData>>,
        PaginatedState<FeedActivityData>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
