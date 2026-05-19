import 'package:equatable/equatable.dart';

import '../../domain/entities/lesson_unit_data.dart';

/// UI-ready data for the Lessons Path screen.
class LessonsPathViewData extends Equatable {
  const LessonsPathViewData({
    required this.categoryTitle,
    required this.units,
    required this.progress,
    required this.currentUnits,
    required this.totalUnits,
    required this.nextUnitNumber,
    required this.levelName,
  });

  final String categoryTitle;
  final List<LessonUnitData> units;
  final double progress;
  final int currentUnits;
  final int totalUnits;
  final int nextUnitNumber;
  final String levelName;

  @override
  List<Object?> get props => [
        categoryTitle,
        units,
        progress,
        currentUnits,
        totalUnits,
        nextUnitNumber,
        levelName,
      ];
}
