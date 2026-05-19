// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserProgressNotifier)
final userProgressProvider = UserProgressNotifierProvider._();

final class UserProgressNotifierProvider extends $NotifierProvider<
    UserProgressNotifier, PaginatedState<LessonProgressModel>> {
  UserProgressNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userProgressProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userProgressNotifierHash();

  @$internal
  @override
  UserProgressNotifier create() => UserProgressNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginatedState<LessonProgressModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PaginatedState<LessonProgressModel>>(value),
    );
  }
}

String _$userProgressNotifierHash() =>
    r'bbe9f1c7f8704b412e8a10057187c14f30e1d02f';

abstract class _$UserProgressNotifier
    extends $Notifier<PaginatedState<LessonProgressModel>> {
  PaginatedState<LessonProgressModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PaginatedState<LessonProgressModel>,
        PaginatedState<LessonProgressModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PaginatedState<LessonProgressModel>,
            PaginatedState<LessonProgressModel>>,
        PaginatedState<LessonProgressModel>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
