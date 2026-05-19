// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crash_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crashService)
final crashServiceProvider = CrashServiceProvider._();

final class CrashServiceProvider
    extends $FunctionalProvider<CrashService, CrashService, CrashService>
    with $Provider<CrashService> {
  CrashServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'crashServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crashServiceHash();

  @$internal
  @override
  $ProviderElement<CrashService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CrashService create(Ref ref) {
    return crashService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrashService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CrashService>(value),
    );
  }
}

String _$crashServiceHash() => r'380f344b5d8cf3a31df51eda8b4479f4f6b882e3';
