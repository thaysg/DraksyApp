// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lessonDetailView)
final lessonDetailViewProvider = LessonDetailViewProvider._();

final class LessonDetailViewProvider extends $FunctionalProvider<
    LessonDetailViewData,
    LessonDetailViewData,
    LessonDetailViewData> with $Provider<LessonDetailViewData> {
  LessonDetailViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonDetailViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonDetailViewHash();

  @$internal
  @override
  $ProviderElement<LessonDetailViewData> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LessonDetailViewData create(Ref ref) {
    return lessonDetailView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonDetailViewData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonDetailViewData>(value),
    );
  }
}

String _$lessonDetailViewHash() => r'0eb234b129f46b19b8f46cd0ddfbce64134beece';
