// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LessonSession)
final lessonSessionProvider = LessonSessionProvider._();

final class LessonSessionProvider
    extends $NotifierProvider<LessonSession, LessonSessionState> {
  LessonSessionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonSessionProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonSessionHash();

  @$internal
  @override
  LessonSession create() => LessonSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonSessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonSessionState>(value),
    );
  }
}

String _$lessonSessionHash() => r'2e166d278a77f6e82fc02229cb57e4041bfa31ad';

abstract class _$LessonSession extends $Notifier<LessonSessionState> {
  LessonSessionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LessonSessionState, LessonSessionState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<LessonSessionState, LessonSessionState>,
        LessonSessionState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(lessonNodes)
final lessonNodesProvider = LessonNodesFamily._();

final class LessonNodesProvider extends $FunctionalProvider<
        AsyncValue<List<NodeModel>>, List<NodeModel>, FutureOr<List<NodeModel>>>
    with $FutureModifier<List<NodeModel>>, $FutureProvider<List<NodeModel>> {
  LessonNodesProvider._(
      {required LessonNodesFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'lessonNodesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonNodesHash();

  @override
  String toString() {
    return r'lessonNodesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<NodeModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<NodeModel>> create(Ref ref) {
    final argument = this.argument as String;
    return lessonNodes(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LessonNodesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonNodesHash() => r'dd0d675518cb32f7aed063544e06b2fed2fb5538';

final class LessonNodesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<NodeModel>>, String> {
  LessonNodesFamily._()
      : super(
          retry: null,
          name: r'lessonNodesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  LessonNodesProvider call(
    String lessonId,
  ) =>
      LessonNodesProvider._(argument: lessonId, from: this);

  @override
  String toString() => r'lessonNodesProvider';
}
