// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_path_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lessonsPathView)
final lessonsPathViewProvider = LessonsPathViewFamily._();

final class LessonsPathViewProvider extends $FunctionalProvider<
        AsyncValue<LessonsPathViewData>,
        LessonsPathViewData,
        FutureOr<LessonsPathViewData>>
    with
        $FutureModifier<LessonsPathViewData>,
        $FutureProvider<LessonsPathViewData> {
  LessonsPathViewProvider._(
      {required LessonsPathViewFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'lessonsPathViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonsPathViewHash();

  @override
  String toString() {
    return r'lessonsPathViewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LessonsPathViewData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LessonsPathViewData> create(Ref ref) {
    final argument = this.argument as String;
    return lessonsPathView(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LessonsPathViewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonsPathViewHash() => r'e31a79ca9c2a086ceda9e5307319e07580ee13f2';

final class LessonsPathViewFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LessonsPathViewData>, String> {
  LessonsPathViewFamily._()
      : super(
          retry: null,
          name: r'lessonsPathViewProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  LessonsPathViewProvider call(
    String categoryTitle,
  ) =>
      LessonsPathViewProvider._(argument: categoryTitle, from: this);

  @override
  String toString() => r'lessonsPathViewProvider';
}

@ProviderFor(randomDragon)
final randomDragonProvider = RandomDragonProvider._();

final class RandomDragonProvider
    extends $FunctionalProvider<String, String, String> with $Provider<String> {
  RandomDragonProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'randomDragonProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$randomDragonHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return randomDragon(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$randomDragonHash() => r'c248a83eb32802f2a6becaf758ee87ca93aa30f5';

@ProviderFor(LessonPathUnits)
final lessonPathUnitsProvider = LessonPathUnitsFamily._();

final class LessonPathUnitsProvider
    extends $NotifierProvider<LessonPathUnits, PaginatedState<LessonUnitData>> {
  LessonPathUnitsProvider._(
      {required LessonPathUnitsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'lessonPathUnitsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonPathUnitsHash();

  @override
  String toString() {
    return r'lessonPathUnitsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LessonPathUnits create() => LessonPathUnits();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginatedState<LessonUnitData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PaginatedState<LessonUnitData>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LessonPathUnitsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonPathUnitsHash() => r'111fd51406a98d7161ac9ef8006cf9d1b48c45ae';

final class LessonPathUnitsFamily extends $Family
    with
        $ClassFamilyOverride<
            LessonPathUnits,
            PaginatedState<LessonUnitData>,
            PaginatedState<LessonUnitData>,
            PaginatedState<LessonUnitData>,
            String> {
  LessonPathUnitsFamily._()
      : super(
          retry: null,
          name: r'lessonPathUnitsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  LessonPathUnitsProvider call(
    String levelName,
  ) =>
      LessonPathUnitsProvider._(argument: levelName, from: this);

  @override
  String toString() => r'lessonPathUnitsProvider';
}

abstract class _$LessonPathUnits
    extends $Notifier<PaginatedState<LessonUnitData>> {
  late final _$args = ref.$arg as String;
  String get levelName => _$args;

  PaginatedState<LessonUnitData> build(
    String levelName,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<PaginatedState<LessonUnitData>, PaginatedState<LessonUnitData>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PaginatedState<LessonUnitData>,
            PaginatedState<LessonUnitData>>,
        PaginatedState<LessonUnitData>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

@ProviderFor(SelectedOption)
final selectedOptionProvider = SelectedOptionProvider._();

final class SelectedOptionProvider
    extends $NotifierProvider<SelectedOption, int> {
  SelectedOptionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedOptionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedOptionHash();

  @$internal
  @override
  SelectedOption create() => SelectedOption();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedOptionHash() => r'e8043fc644bb18ed951edb7bf304b3005b7d7bda';

abstract class _$SelectedOption extends $Notifier<int> {
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
