// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lessonsView)
final lessonsViewProvider = LessonsViewProvider._();

final class LessonsViewProvider extends $FunctionalProvider<
        AsyncValue<LessonsViewData>, LessonsViewData, FutureOr<LessonsViewData>>
    with $FutureModifier<LessonsViewData>, $FutureProvider<LessonsViewData> {
  LessonsViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonsViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonsViewHash();

  @$internal
  @override
  $FutureProviderElement<LessonsViewData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LessonsViewData> create(Ref ref) {
    return lessonsView(ref);
  }
}

String _$lessonsViewHash() => r'88f6aa1341a73824aefa935ca85cb961f89ea699';
