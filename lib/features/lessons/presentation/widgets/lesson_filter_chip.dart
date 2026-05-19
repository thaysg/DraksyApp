import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class LessonFilterChip extends StatelessWidget {
  const LessonFilterChip({
    required this.label,
    required this.isSelected,
    super.key,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        color: isSelected
            ? AppColors.primaryAppColor
            : (context.isDarkMode
                ? AppColors.surfaceDark
                : AppColors.backgroundLight),
        opacity: 1,
        borderColor: AppColors.transparent,
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.primaryAppColor.withValues(alpha: 0.3)
                : AppColors.surface(context).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        child: Text(
          label,
          style: AppTextStyles.bodyMedium(context).copyWith(
            fontWeight: FontWeight.w800,
            color: isSelected
                ? AppColors.surfaceLight
                : AppColors.textSecondary(context),
          ),
        ),
      );
}
