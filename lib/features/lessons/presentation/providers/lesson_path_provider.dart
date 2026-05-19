import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/models/pagination_response.dart';
import '../../../../core/utils/pagination/paginated_notifier.dart';
import '../../../../core/utils/pagination/paginated_state.dart';
import '../../data/providers/lesson_repository_providers.dart';
import '../../domain/entities/lesson_node_state.dart';
import '../../domain/entities/lesson_unit_data.dart';
import '../../domain/providers/lesson_usecase_providers.dart';
import '../models/lessons_path_view_data.dart';
import 'level_utils.dart';

part 'lesson_path_provider.g.dart';

@riverpod
Future<LessonsPathViewData> lessonsPathView(
    Ref ref, String categoryTitle) async {
  final repository = ref.watch(lessonRepositoryProvider);
  final levelsResult = await repository.getLevels();
  final levels = levelsResult.data ?? [];

  // Find level by matching categoryTitle with localized title
  final level = levels.firstWhere(
    (l) => LevelUtils.getLocalizedTitleFromRef(ref, l.name) == categoryTitle,
    orElse: () => levels.first, // Fallback
  );

  // We don't watch the future here because it's now a paginated state notifier
  // We just return the metadata, the actual units list is handled by the
  //PaginatedState
  final difficulty = LevelUtils.mapLevelToDifficulty(level.name);
  final completedResult = await repository.getCompletedLessonsCount(difficulty);
  final completedCount = completedResult.data ?? 0;

  final progress =
      level.lessonCount > 0 ? completedCount / level.lessonCount : 0.0;

  return LessonsPathViewData(
    categoryTitle: categoryTitle,
    units: const [], // Will be provided by PaginatedState
    progress: progress,
    currentUnits: completedCount,
    totalUnits: level.lessonCount,
    nextUnitNumber: completedCount + 1,
    levelName: level.name, // Added field to ViewData to link the notifier
  );
}

@riverpod
String randomDragon(Ref ref) {
  const dragons = [
    AppImages.dragonOrangeWaving,
    AppImages.dragonBlueSitting,
    AppImages.dragonGreenLookingSide,
    AppImages.dragonPinkExcited,
    AppImages.dragonTealWaving,
    AppImages.dragonBlueFlying,
    AppImages.dragonGreenWinking,
    AppImages.dragonPurpleLaughing,
    AppImages.dragonRedWaving,
    AppImages.dragonGreenWaving,
    AppImages.dragonBlueShy,
    AppImages.dragonOrangeJumping,
    AppImages.dragonPurpleArmsCrossed,
    AppImages.dragonBlackHappy,
    AppImages.dragonWhiteHappy,
    AppImages.dragonGoldPlayful,
    AppImages.dragonTealSurprised,
    AppImages.dragonPinkExcited,
    AppImages.dragonBlueShy2,
    AppImages.dragonOrangeWaving2,
    AppImages.dragon29,
    AppImages.dragon30,
    AppImages.dragon31,
    AppImages.dragon32,
    AppImages.dragon33,
    AppImages.dragon34,
    AppImages.dragon35,
    AppImages.dragon36,
    AppImages.dragon37,
    AppImages.dragon38,
    AppImages.dragon39,
    AppImages.dragon40,
    AppImages.dragon41,
    AppImages.dragon42,
    AppImages.dragon43,
    AppImages.dragon44,
    AppImages.dragon45,
    AppImages.dragon46,
    AppImages.dragon47,
    AppImages.dragon48,
    AppImages.dragon49,
    AppImages.dragon52,
  ];

  return (dragons.toList()..shuffle()).first;
}

@riverpod
class LessonPathUnits extends _$LessonPathUnits
    with PaginatedNotifierMixin<LessonUnitData> {
  @override
  PaginatedState<LessonUnitData> build(String levelName) {
    Future.microtask(loadInitial);
    return PaginatedState<LessonUnitData>.initial().copyWith(isLoading: true);
  }

  /// Returns the index of the lesson with state [LessonNodeState.current].
  int get currentLessonIndex => state.items.indexWhere(
        (u) => u.state == LessonNodeState.current,
      );

  @override
  PageFetcher<LessonUnitData> get fetchPage => (request) async {
        final difficulty = LevelUtils.mapLevelToDifficulty(levelName);
        final getUnits = ref.read(getUnitsByDifficultyProvider);

        final response = await getUnits(
          difficulty: difficulty,
          request: request,
        );

        if (response.error) {
          throw Exception(response.message);
        }

        final paginatedResponse = response.data!;
        final units = paginatedResponse.items;
        final unitIds = units.map((u) => u.id).toList();

        final repository = ref.read(lessonRepositoryProvider);
        final progressResult = await repository.getUnitsProgress(unitIds);
        final progressMap = progressResult.data ?? {};

        final pathUnits = <LessonUnitData>[];

        for (var i = 0; i < units.length; i++) {
          final u = units[i];
          final accuracy = progressMap[u.id];
          final isCompleted = accuracy != null;

          LessonNodeState state;

          if (isCompleted) {
            state = LessonNodeState.completed;
          } else if (i == 0 && request.page == 1) {
            // First lesson of the first page is always unlocked
            // if not completed
            state = LessonNodeState.current;
          } else {
            // Check previous lesson accuracy (This logic might need refinement
            // for cross-page dependencies, but for now we follow the pattern)
            final prevUnit = i > 0 ? units[i - 1] : null;
            final prevAccuracy =
                prevUnit != null ? (progressMap[prevUnit.id] ?? 0.0) : 1.0;

            if (prevAccuracy >= 0.8) {
              state = LessonNodeState.current;
            } else {
              state = LessonNodeState.locked;
            }
          }

          pathUnits.add(LessonUnitData(
            id: u.id,
            lessonId: u.lessonId,
            unitNumber: u.orderIndex,
            state: state,
            title: u.title,
          ));
        }

        return PaginationResponse(
          items: pathUnits,
          totalCount: paginatedResponse.totalCount,
          currentPage: paginatedResponse.currentPage,
          lastPage: paginatedResponse.lastPage,
        );
      };
}

@riverpod
class SelectedOption extends _$SelectedOption {
  @override
  int build() => -1; // -1 = nenhuma selecionada

  int get select => state;
  set select(int index) => state = index;
  void clear() => state = -1;
}
