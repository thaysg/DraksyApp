import 'lesson_node_state.dart';

class LessonUnitData {
  const LessonUnitData({
    required this.id,
    required this.lessonId, // ← novo
    required this.unitNumber,
    required this.state,
    this.title = '',
  });

  final String id;
  final String lessonId; // ← novo
  final int unitNumber;
  final LessonNodeState state;
  final String title;
}
