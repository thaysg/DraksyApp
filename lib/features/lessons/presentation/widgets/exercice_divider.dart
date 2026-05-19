import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ExerciceDivider extends StatelessWidget {
  const ExerciceDivider({super.key});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
              child: Divider(
                  color:
                      AppColors.textSecondary(context).withValues(alpha: 0.3))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              context.l10n.exercise.toUpperCase(),
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textSecondary(context),
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.textSecondary(context).withValues(alpha: 0.3),
            ),
          ),
        ],
      );
}
