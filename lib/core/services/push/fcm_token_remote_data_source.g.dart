// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_token_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fcmTokenRemoteDataSource)
final fcmTokenRemoteDataSourceProvider = FcmTokenRemoteDataSourceProvider._();

final class FcmTokenRemoteDataSourceProvider extends $FunctionalProvider<
    FcmTokenRemoteDataSource,
    FcmTokenRemoteDataSource,
    FcmTokenRemoteDataSource> with $Provider<FcmTokenRemoteDataSource> {
  FcmTokenRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fcmTokenRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fcmTokenRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FcmTokenRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FcmTokenRemoteDataSource create(Ref ref) {
    return fcmTokenRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmTokenRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FcmTokenRemoteDataSource>(value),
    );
  }
}

String _$fcmTokenRemoteDataSourceHash() =>
    r'2e8c6d3ae41c1faca8f926c16b29d730948f575a';
