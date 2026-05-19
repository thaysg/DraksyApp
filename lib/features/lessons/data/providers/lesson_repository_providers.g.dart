// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [LessonRepository] implementation.

@ProviderFor(lessonRepository)
final lessonRepositoryProvider = LessonRepositoryProvider._();

/// Provides the [LessonRepository] implementation.

final class LessonRepositoryProvider extends $FunctionalProvider<
    LessonRepository,
    LessonRepository,
    LessonRepository> with $Provider<LessonRepository> {
  /// Provides the [LessonRepository] implementation.
  LessonRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonRepositoryHash();

  @$internal
  @override
  $ProviderElement<LessonRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LessonRepository create(Ref ref) {
    return lessonRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRepository>(value),
    );
  }
}

String _$lessonRepositoryHash() => r'0342d4f286dde6139ee8105c0d9811c8745ad938';
