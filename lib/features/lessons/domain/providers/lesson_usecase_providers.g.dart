// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [GetLessonNodes] use case.

@ProviderFor(getLessonNodes)
final getLessonNodesProvider = GetLessonNodesProvider._();

/// Provides the [GetLessonNodes] use case.

final class GetLessonNodesProvider
    extends $FunctionalProvider<GetLessonNodes, GetLessonNodes, GetLessonNodes>
    with $Provider<GetLessonNodes> {
  /// Provides the [GetLessonNodes] use case.
  GetLessonNodesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getLessonNodesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getLessonNodesHash();

  @$internal
  @override
  $ProviderElement<GetLessonNodes> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetLessonNodes create(Ref ref) {
    return getLessonNodes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLessonNodes value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLessonNodes>(value),
    );
  }
}

String _$getLessonNodesHash() => r'd490417a1f0045e2cc79482fae5d525f2a8980ee';

/// Provides the [CompleteNode] use case.

@ProviderFor(completeNode)
final completeNodeProvider = CompleteNodeProvider._();

/// Provides the [CompleteNode] use case.

final class CompleteNodeProvider
    extends $FunctionalProvider<CompleteNode, CompleteNode, CompleteNode>
    with $Provider<CompleteNode> {
  /// Provides the [CompleteNode] use case.
  CompleteNodeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'completeNodeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$completeNodeHash();

  @$internal
  @override
  $ProviderElement<CompleteNode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CompleteNode create(Ref ref) {
    return completeNode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompleteNode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompleteNode>(value),
    );
  }
}

String _$completeNodeHash() => r'4d3b9d47d225408c4438b8939f4d637d50f3a263';

/// Provides the [GetUnitsByDifficulty] use case.

@ProviderFor(getUnitsByDifficulty)
final getUnitsByDifficultyProvider = GetUnitsByDifficultyProvider._();

/// Provides the [GetUnitsByDifficulty] use case.

final class GetUnitsByDifficultyProvider extends $FunctionalProvider<
    GetUnitsByDifficulty,
    GetUnitsByDifficulty,
    GetUnitsByDifficulty> with $Provider<GetUnitsByDifficulty> {
  /// Provides the [GetUnitsByDifficulty] use case.
  GetUnitsByDifficultyProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getUnitsByDifficultyProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getUnitsByDifficultyHash();

  @$internal
  @override
  $ProviderElement<GetUnitsByDifficulty> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetUnitsByDifficulty create(Ref ref) {
    return getUnitsByDifficulty(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUnitsByDifficulty value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUnitsByDifficulty>(value),
    );
  }
}

String _$getUnitsByDifficultyHash() =>
    r'03ec20020483a5375523463c86831ca817ab26af';

/// Provides the [GetUserProgress] use case.

@ProviderFor(getUserProgress)
final getUserProgressProvider = GetUserProgressProvider._();

/// Provides the [GetUserProgress] use case.

final class GetUserProgressProvider extends $FunctionalProvider<GetUserProgress,
    GetUserProgress, GetUserProgress> with $Provider<GetUserProgress> {
  /// Provides the [GetUserProgress] use case.
  GetUserProgressProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getUserProgressProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getUserProgressHash();

  @$internal
  @override
  $ProviderElement<GetUserProgress> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetUserProgress create(Ref ref) {
    return getUserProgress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserProgress>(value),
    );
  }
}

String _$getUserProgressHash() => r'1a290d360717709d19cc5836b4105b5d47e9202c';
