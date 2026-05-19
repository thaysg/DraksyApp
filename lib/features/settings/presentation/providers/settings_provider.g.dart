// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Settings)
final settingsProvider = SettingsProvider._();

final class SettingsProvider extends $NotifierProvider<Settings, void> {
  SettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$settingsHash() => r'e6674fc3057365f66d458843867745076e8b4d71';

abstract class _$Settings extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(settingsView)
final settingsViewProvider = SettingsViewProvider._();

final class SettingsViewProvider extends $FunctionalProvider<SettingsViewData,
    SettingsViewData, SettingsViewData> with $Provider<SettingsViewData> {
  SettingsViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsViewHash();

  @$internal
  @override
  $ProviderElement<SettingsViewData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsViewData create(Ref ref) {
    return settingsView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsViewData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsViewData>(value),
    );
  }
}

String _$settingsViewHash() => r'71df437e29c80ca9805e0016f334f0838e934c0b';
