// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_remote_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [FeedRemoteDataSource] backed by Supabase.

@ProviderFor(feedRemoteDataSource)
final feedRemoteDataSourceProvider = FeedRemoteDataSourceProvider._();

/// Provides the [FeedRemoteDataSource] backed by Supabase.

final class FeedRemoteDataSourceProvider extends $FunctionalProvider<
    FeedRemoteDataSource,
    FeedRemoteDataSource,
    FeedRemoteDataSource> with $Provider<FeedRemoteDataSource> {
  /// Provides the [FeedRemoteDataSource] backed by Supabase.
  FeedRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FeedRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedRemoteDataSource create(Ref ref) {
    return feedRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedRemoteDataSource>(value),
    );
  }
}

String _$feedRemoteDataSourceHash() =>
    r'8635d1e79f2403e9f9f528c89d8906c05ba86143';
