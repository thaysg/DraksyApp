import 'package:flutter/material.dart';

import '../../domain/entities/lesson_node_state.dart';
import 'lesson_path_current_node.dart';
import 'lesson_path_static_node.dart';

class LessonPathNode extends StatelessWidget {
  const LessonPathNode({
    required this.unitNumber,
    required this.state,
    this.onTap,
    super.key,
  });

  final int unitNumber;
  final LessonNodeState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: state == LessonNodeState.locked ? null : onTap,
        child: state == LessonNodeState.current
            ? const LessonPathCurrentNode()
            : LessonPathStaticNode(state: state),
      );
}
