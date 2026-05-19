import 'package:equatable/equatable.dart';

import '../../data/models/node_model.dart';
import '../providers/lesson_provider.dart';

/// UI-ready data for the Lesson session.
class LessonViewData extends Equatable {
  const LessonViewData({
    required this.unitId,
    required this.lessonId,
    required this.lessonTitle,
    required this.nodes,
    required this.session,
  });

  final String unitId;
  final String lessonId;
  final String lessonTitle;
  final List<NodeModel> nodes;
  final LessonSessionState session;

  double get progress =>
      session.currentIndex / (nodes.isEmpty ? 1 : nodes.length - 1);

  @override
  List<Object?> get props => [unitId, lessonId, lessonTitle, nodes, session];
}
