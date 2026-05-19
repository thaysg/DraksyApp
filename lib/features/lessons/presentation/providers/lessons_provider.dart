import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/lesson_repository_providers.dart';
import '../models/lessons_view_data.dart';
import 'level_utils.dart';

part 'lessons_provider.g.dart';

@riverpod
Future<LessonsViewData> lessonsView(Ref ref) async {
  final repository = ref.watch(lessonRepositoryProvider);
  final levelsResult = await repository.getLevels();

  // If there's an error or no data, we could return mock or empty.
  final levels = levelsResult.data ?? [];

  final categories =
      await Future.wait<LessonCategoryData>(levels.map((l) async {
    final difficulty = LevelUtils.mapLevelToDifficulty(l.name);
    final completedResult =
        await repository.getCompletedLessonsCount(difficulty);
    final completedCount = completedResult.data ?? 0;

    final progress = l.lessonCount > 0 ? completedCount / l.lessonCount : 0.0;

    return LessonCategoryData(
      level: l.orderIndex,
      title: LevelUtils.getLocalizedTitleFromRef(ref, l.name),
      description: LevelUtils.getLocalizedDescription(ref, l.name),
      progress: progress,
      timeInMinutes: l.orderIndex * 10 + 5,
      icon: LevelUtils.getIconForLevel(l.name),
      iconColor: LevelUtils.getColorForLevel(l.name),
      isLocked: l.orderIndex > 1,
    );
  }));

  return LessonsViewData(
    lives: 'Full',
    gems: '450',
    categories: categories,
  );
}
