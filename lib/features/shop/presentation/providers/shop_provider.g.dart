// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shopView)
final shopViewProvider = ShopViewProvider._();

final class ShopViewProvider extends $FunctionalProvider<
        AsyncValue<ShopViewData>, ShopViewData, FutureOr<ShopViewData>>
    with $FutureModifier<ShopViewData>, $FutureProvider<ShopViewData> {
  ShopViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'shopViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$shopViewHash();

  @$internal
  @override
  $FutureProviderElement<ShopViewData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ShopViewData> create(Ref ref) {
    return shopView(ref);
  }
}

String _$shopViewHash() => r'f3c10d718e85d79a6bad8009a7838fdf6d75035c';
