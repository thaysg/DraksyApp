import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../models/lesson_detail_view_data.dart';

class LessonOptionsGrid extends StatelessWidget {
  const LessonOptionsGrid({
    required this.options,
    required this.selectedOptionIndex,
    super.key,
  });

  final List<LessonOptionData> options;
  final int selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 4 : 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: isDesktop ? 1.0 : 0.85,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = selectedOptionIndex == index;
        final option = options[index];

        return GestureDetector(
          onTap: () {}, // Handled by Page layer in real app, mocked for now
          child: CustomDecoratedBox(
            opacity: 1,
            padding: const EdgeInsets.all(12),
            borderColor:
                isSelected ? AppColors.primaryAppColor : AppColors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDecoratedBox(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  opacity: 0.05,
                  color: isSelected
                      ? AppColors.primaryAppColor.withValues(alpha: 0.05)
                      : context.isDarkMode
                          ? AppColors.backgroundDark
                          : AppColors.backgroundLight,
                  child: Text(
                    option.emoji,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ),
                8.heightBox,
                Text(
                  option.label,
                  style: AppTextStyles.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? AppColors.primaryAppColor
                        : AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
