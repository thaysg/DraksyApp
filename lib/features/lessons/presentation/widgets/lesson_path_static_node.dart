import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../../domain/entities/lesson_node_state.dart';

class LessonPathStaticNode extends StatelessWidget {
  const LessonPathStaticNode({
    required this.state,
    super.key,
  });

  final LessonNodeState state;

  @override
  Widget build(BuildContext context) {
    final isCompleted = state == LessonNodeState.completed;

    return CustomDecoratedBox(
      shape: BoxShape.circle,
      padding: EdgeInsets.zero,
      opacity: isCompleted ? 1.0 : 0.4,
      color: isCompleted ? AppColors.success : AppColors.textSecondaryLight,
      child: SizedBox.square(
        dimension: 56.r,
        child: Icon(
          isCompleted ? Icons.check_rounded : Icons.lock_rounded,
          color: isCompleted
              ? AppColors.surfaceLight
              : AppColors.textSecondaryLight,
          size: isCompleted ? 28.sp : 24.sp,
        ),
      ),
    );
  }
}
