import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import 'category_progres_widget.dart';
import 'progress_stacked.dart';

class LessonCategoryProgressCard extends StatelessWidget {
  const LessonCategoryProgressCard({
    required this.progress,
    required this.currentUnits,
    required this.totalUnits,
    required this.nextUnitNumber,
    super.key,
  });

  final double progress;
  final int currentUnits;
  final int totalUnits;
  final int nextUnitNumber;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomDecoratedBox(
          opacity: 1,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondaryLight.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          child: Row(
            children: [
              Expanded(
                child: CategoryProgressWidget(
                  progress: progress,
                  currentUnits: currentUnits,
                  totalUnits: totalUnits,
                  nextUnitNumber: nextUnitNumber,
                ),
              ),
              ProgressStacked(progress: progress),
            ],
          ),
        ),
      );
}
