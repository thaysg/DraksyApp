// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeView)
final homeViewProvider = HomeViewProvider._();

final class HomeViewProvider extends $FunctionalProvider<
        AsyncValue<HomeViewData>, HomeViewData, FutureOr<HomeViewData>>
    with $FutureModifier<HomeViewData>, $FutureProvider<HomeViewData> {
  HomeViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'homeViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$homeViewHash();

  @$internal
  @override
  $FutureProviderElement<HomeViewData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<HomeViewData> create(Ref ref) {
    return homeView(ref);
  }
}

String _$homeViewHash() => r'8f3dffec78b4938176ed71b9e6315a896bb23fae';
