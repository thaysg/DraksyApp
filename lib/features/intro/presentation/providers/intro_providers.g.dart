// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(introView)
final introViewProvider = IntroViewProvider._();

final class IntroViewProvider
    extends $FunctionalProvider<IntroViewData, IntroViewData, IntroViewData>
    with $Provider<IntroViewData> {
  IntroViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'introViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$introViewHash();

  @$internal
  @override
  $ProviderElement<IntroViewData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IntroViewData create(Ref ref) {
    return introView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntroViewData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntroViewData>(value),
    );
  }
}

String _$introViewHash() => r'e0ba5cf0962493aa1df4e265febbac4c389331d8';

@ProviderFor(IntroIndex)
final introIndexProvider = IntroIndexProvider._();

final class IntroIndexProvider extends $NotifierProvider<IntroIndex, int> {
  IntroIndexProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'introIndexProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$introIndexHash();

  @$internal
  @override
  IntroIndex create() => IntroIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$introIndexHash() => r'7705b6d68f007ace00d8a87bc48ccc894d98e72a';

abstract class _$IntroIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<int, int>, int, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(pageController)
final pageControllerProvider = PageControllerProvider._();

final class PageControllerProvider
    extends $FunctionalProvider<PageController, PageController, PageController>
    with $Provider<PageController> {
  PageControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pageControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pageControllerHash();

  @$internal
  @override
  $ProviderElement<PageController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PageController create(Ref ref) {
    return pageController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PageController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PageController>(value),
    );
  }
}

String _$pageControllerHash() => r'1a42bfdea0db295df0782195891433c990e0582f';
