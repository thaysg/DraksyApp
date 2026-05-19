// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_remote_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [LessonRemoteDataSource] backed by Supabase.

@ProviderFor(lessonRemoteDataSource)
final lessonRemoteDataSourceProvider = LessonRemoteDataSourceProvider._();

/// Provides the [LessonRemoteDataSource] backed by Supabase.

final class LessonRemoteDataSourceProvider extends $FunctionalProvider<
    LessonRemoteDataSource,
    LessonRemoteDataSource,
    LessonRemoteDataSource> with $Provider<LessonRemoteDataSource> {
  /// Provides the [LessonRemoteDataSource] backed by Supabase.
  LessonRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LessonRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LessonRemoteDataSource create(Ref ref) {
    return lessonRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRemoteDataSource>(value),
    );
  }
}

String _$lessonRemoteDataSourceHash() =>
    r'c9251cdd2770fc729ab2be6029560da3d45e11e6';
