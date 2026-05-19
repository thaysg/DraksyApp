import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/lesson_repository_providers.dart';
import '../usecases/complete_node.dart';
import '../usecases/get_lesson_nodes.dart';
import '../usecases/get_units_by_difficulty.dart';
import '../usecases/get_user_progress.dart';

part 'lesson_usecase_providers.g.dart';

/// Provides the [GetLessonNodes] use case.
@riverpod
GetLessonNodes getLessonNodes(Ref ref) {
  final repository = ref.watch(lessonRepositoryProvider);
  return GetLessonNodes(repository);
}

/// Provides the [CompleteNode] use case.
@riverpod
CompleteNode completeNode(Ref ref) {
  final repository = ref.watch(lessonRepositoryProvider);
  return CompleteNode(repository);
}

/// Provides the [GetUnitsByDifficulty] use case.
@riverpod
GetUnitsByDifficulty getUnitsByDifficulty(Ref ref) {
  final repository = ref.watch(lessonRepositoryProvider);
  return GetUnitsByDifficulty(repository);
}

/// Provides the [GetUserProgress] use case.
@riverpod
GetUserProgress getUserProgress(Ref ref) {
  final repository = ref.watch(lessonRepositoryProvider);
  return GetUserProgress(repository);
}
