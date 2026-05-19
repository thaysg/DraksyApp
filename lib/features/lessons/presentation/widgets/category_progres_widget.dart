import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class CategoryProgressWidget extends StatelessWidget {
  const CategoryProgressWidget({
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
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.categoryProgress,
            style: AppTextStyles.bodySmall(context),
          ),
          4.heightBox,
          Text(
            '${(progress * 100).toInt()}%',
            style: AppTextStyles.h2(context).copyWith(
              color: AppColors.onSurface(context),
            ),
          ),
          Text(
            context.l10n.unitsCount(currentUnits, totalUnits),
            style: AppTextStyles.bodySmall(context),
          ),
          12.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            color: AppColors.primary(context),
            opacity: 0.15,
            borderRadius: BorderRadius.circular(20.r),
            child: Text(
              context.l10n.nextUnit(nextUnitNumber),
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.primary(context),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
}
