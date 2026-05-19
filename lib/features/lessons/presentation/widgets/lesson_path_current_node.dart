import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class LessonPathCurrentNode extends StatefulWidget {
  const LessonPathCurrentNode({super.key});

  @override
  State<LessonPathCurrentNode> createState() => _LessonPathCurrentNodeState();
}

class _LessonPathCurrentNodeState extends State<LessonPathCurrentNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = 0.9 + (_pulseController.value * 0.1);

          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer halo (animated)
              Transform.scale(
                scale: scale,
                child: CustomDecoratedBox(
                  shape: BoxShape.circle,
                  padding: EdgeInsets.zero,
                  color: AppColors.primaryAppColor,
                  opacity: 0.15,
                  child: SizedBox.square(dimension: 96.r),
                ),
              ),
              // Middle ring
              CustomDecoratedBox(
                shape: BoxShape.circle,
                padding: EdgeInsets.zero,
                color: AppColors.primaryAppColor,
                opacity: 0.25,
                child: SizedBox.square(dimension: 76.r),
              ),
              // Inner solid circle
              CustomDecoratedBox(
                shape: BoxShape.circle,
                padding: EdgeInsets.zero,
                color: AppColors.primaryAppColor,
                opacity: 1,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAppColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                child: SizedBox.square(
                  dimension: 56.r,
                  child: Icon(
                    Icons.star_rounded,
                    color: AppColors.surfaceLight,
                    size: 32.sp,
                  ),
                ),
              ),
            ],
          );
        },
      );
}
