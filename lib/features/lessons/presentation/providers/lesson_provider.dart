import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../profile/presentation/providers/user_stats_provider.dart';
import '../../data/models/node_model.dart';
import '../../domain/providers/lesson_usecase_providers.dart';
import 'lesson_path_provider.dart';
import 'lessons_provider.dart';

part 'lesson_provider.g.dart';

/// State for the current lesson session.
class LessonSessionState {
  const LessonSessionState({
    this.currentIndex = 0,
    this.selectedAnswer,
    this.isAnswered = false,
    this.dragonImageKey,
    this.totalXp = 0,
    this.correctAnswers = 0,
    this.totalQuestions = 0,
    this.totalNodes = 0,
    this.isLessonFinished = false,
  });

  final int currentIndex;
  final int? selectedAnswer;
  final bool isAnswered;
  final String? dragonImageKey;
  final int totalXp;
  final int correctAnswers;
  final int totalQuestions;
  final int totalNodes;
  final bool isLessonFinished;

  bool get hasSelected => selectedAnswer != null;

  double get accuracy =>
      totalQuestions > 0 ? correctAnswers / totalQuestions : 0;

  LessonSessionState copyWith({
    int? currentIndex,
    int? selectedAnswer,
    bool? isAnswered,
    String? dragonImageKey,
    int? totalXp,
    int? correctAnswers,
    int? totalQuestions,
    int? totalNodes,
    bool? isLessonFinished,
    bool clearSelectedAnswer = false,
    bool clearDragonImageKey = false,
  }) =>
      LessonSessionState(
        currentIndex: currentIndex ?? this.currentIndex,
        selectedAnswer: clearSelectedAnswer
            ? null
            : (selectedAnswer ?? this.selectedAnswer),
        isAnswered: isAnswered ?? this.isAnswered,
        dragonImageKey: clearDragonImageKey
            ? null
            : (dragonImageKey ?? this.dragonImageKey),
        totalXp: totalXp ?? this.totalXp,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        totalNodes: totalNodes ?? this.totalNodes,
        isLessonFinished: isLessonFinished ?? this.isLessonFinished,
      );
}

@Riverpod(keepAlive: true)
class LessonSession extends _$LessonSession {
  @override
  LessonSessionState build() => const LessonSessionState();

  void init(int totalNodes, int questionCount) {
    // Reset to a fresh state instance with the new lesson's metadata
    state = LessonSessionState(
      totalNodes: totalNodes,
      totalQuestions: questionCount,
    );
  }

  void updateSelectedAnswer(int index) {
    if (state.isAnswered) {
      return;
    }
    state = state.copyWith(selectedAnswer: index);
  }

  void selectAnswer(int index, int correctIndex) {
    if (state.isAnswered) {
      return;
    }

    final isCorrect = index == correctIndex;

    if (!isCorrect) {
      ref.read(userStatsProvider.notifier).reduceLife();
    }

    state = state.copyWith(
      selectedAnswer: index,
      isAnswered: true,
      dragonImageKey: isCorrect ? 'dragon_celebrating' : 'dragon_sad',
      totalXp: isCorrect ? state.totalXp + 10 : state.totalXp,
      correctAnswers:
          isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
    );
  }

  Future<void> finishLesson({
    required String unitId,
    required String lessonId,
    required String nodeId,
  }) async {
    final currentXp = state.totalXp;
    final currentAccuracy = state.accuracy;

    if (currentAccuracy < 0.8) {
      return;
    }

    try {
      final completeNode = ref.read(completeNodeProvider);
      await completeNode(
        unitId: unitId,
        nodeId: nodeId,
        lessonId: lessonId,
        xpEarned: currentXp,
        accuracy: currentAccuracy,
      );
    } catch (e) {
      // Log error but don't block the user from finishing
      debugPrint('Error finishing lesson: $e');
    }

    // Add XP to user stats (local only if remote fails)
    ref.read(userStatsProvider.notifier).addXp(currentXp);

    // Invalidate path providers to refresh the map and unlocking state
    ref
      ..invalidate(lessonsPathViewProvider)
      ..invalidate(lessonPathUnitsProvider)
      ..invalidate(lessonsViewProvider);
  }

  void advance() {
    if (state.currentIndex + 1 >= state.totalNodes) {
      state = state.copyWith(isLessonFinished: true);
      return;
    }

    state = state.copyWith(
      currentIndex: state.currentIndex + 1,
      isAnswered: false,
      clearSelectedAnswer: true,
      clearDragonImageKey: true,
    );
  }

  void reset() {
    state = const LessonSessionState();
  }
}

// Static guard — persists across provider rebuilds
final _rateLimitedLessons = <String, DateTime>{};
final _inFlight = <String>{};

@riverpod
Future<List<NodeModel>> lessonNodes(Ref ref, String lessonId) async {
  // 1. If there's already an active request for this lesson, block duplicate
  if (_inFlight.contains(lessonId)) {
    throw const RateLimitException(
      'Request already in progress, please wait.',
    );
  }

  // 2. If rate limited in the last 5 minutes, skip the request
  final failedAt = _rateLimitedLessons[lessonId];
  if (failedAt != null && DateTime.now().difference(failedAt).inMinutes < 5) {
    throw const RateLimitException(
      'Service temporarily unavailable. Please try again in a few minutes.',
    );
  }

  _inFlight.add(lessonId);

  try {
    final getNodes = ref.read(getLessonNodesProvider);
    final response = await getNodes(lessonId);

    if (response.error) {
      final msg = response.message;
      if (msg.contains('429') || msg.contains('RESOURCE_EXHAUSTED')) {
        // Mark this lesson as rate limited with current timestamp
        _rateLimitedLessons[lessonId] = DateTime.now();
        throw const RateLimitException(
          'Service temporarily unavailable. Please try again in a few minutes.',
        );
      }
      throw Exception(msg);
    }

    // Success — clear rate limit history for this lesson
    _rateLimitedLessons.remove(lessonId);
    return response.data!;
  } finally {
    // Always release the in-flight guard, even on unexpected errors
    _inFlight.remove(lessonId);
  }
}
