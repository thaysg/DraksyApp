import 'package:equatable/equatable.dart';

/// UI-ready data for a lesson option.
class LessonOptionData extends Equatable {
  const LessonOptionData({
    required this.label,
    required this.emoji,
  });

  final String label;
  final String emoji;

  @override
  List<Object?> get props => [label, emoji];
}

/// UI-ready data for the Lesson Detail screen.
class LessonDetailViewData extends Equatable {
  const LessonDetailViewData({
    required this.title,
    required this.meaningTitle,
    required this.targetWord,
    required this.description,
    required this.dragonImage,
    required this.exerciseTitle,
    required this.options,
    required this.selectedOptionIndex,
    required this.currentXp,
    required this.maxXp,
    required this.lives,
  });

  final String title;
  final String meaningTitle;
  final String targetWord;
  final String description;
  final String dragonImage;
  final String exerciseTitle;
  final List<LessonOptionData> options;
  final int selectedOptionIndex;
  final int currentXp;
  final int maxXp;
  final int lives;

  @override
  List<Object?> get props => [
        title,
        meaningTitle,
        targetWord,
        description,
        dragonImage,
        exerciseTitle,
        options,
        selectedOptionIndex,
        currentXp,
        maxXp,
        lives,
      ];
}
