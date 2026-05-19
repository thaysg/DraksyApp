// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_local_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [LessonLocalDataSource] backed by the local database.

@ProviderFor(lessonLocalDataSource)
final lessonLocalDataSourceProvider = LessonLocalDataSourceProvider._();

/// Provides the [LessonLocalDataSource] backed by the local database.

final class LessonLocalDataSourceProvider extends $FunctionalProvider<
    LessonLocalDataSource,
    LessonLocalDataSource,
    LessonLocalDataSource> with $Provider<LessonLocalDataSource> {
  /// Provides the [LessonLocalDataSource] backed by the local database.
  LessonLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonLocalDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<LessonLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LessonLocalDataSource create(Ref ref) {
    return lessonLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonLocalDataSource>(value),
    );
  }
}

String _$lessonLocalDataSourceHash() =>
    r'c356390eb8a84f89f81deb45dcf84566e765a9ad';
