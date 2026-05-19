// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedView)
final feedViewProvider = FeedViewProvider._();

final class FeedViewProvider extends $FunctionalProvider<
        AsyncValue<FeedViewData>, FeedViewData, FutureOr<FeedViewData>>
    with $FutureModifier<FeedViewData>, $FutureProvider<FeedViewData> {
  FeedViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedViewHash();

  @$internal
  @override
  $FutureProviderElement<FeedViewData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FeedViewData> create(Ref ref) {
    return feedView(ref);
  }
}

String _$feedViewHash() => r'31a0ea8a7ccc69ecd36ba15620f72885211513ec';
