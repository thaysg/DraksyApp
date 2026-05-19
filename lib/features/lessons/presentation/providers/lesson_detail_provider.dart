import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/lesson_detail_view_data.dart';
import 'lesson_path_provider.dart';

part 'lesson_detail_provider.g.dart';

@riverpod
LessonDetailViewData lessonDetailView(Ref ref) {
  final selectedOption = ref.watch(selectedOptionProvider);
  final dragon = ref.watch(randomDragonProvider);

  return LessonDetailViewData(
    title: 'Lesson 1', // Mocked, ideally from a source
    meaningTitle: 'Hello\nOlá', // Mocked
    targetWord: 'Hello',
    description: 'Use this when greeting someone.',
    dragonImage: dragon,
    exerciseTitle: 'How do you say Hello?', // Mocked
    options: const [
      LessonOptionData(label: 'Adiós', emoji: '👋'),
      LessonOptionData(label: 'Hola', emoji: '🧑'),
      LessonOptionData(label: 'Gracias', emoji: '🙏'),
      LessonOptionData(label: 'Noches', emoji: '🌙'),
    ],
    selectedOptionIndex: selectedOption,
    currentXp: 40,
    maxXp: 100,
    lives: 5,
  );
}
