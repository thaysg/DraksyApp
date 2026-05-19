import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class LessonSectionClearedBanner extends StatelessWidget {
  const LessonSectionClearedBanner({
    required this.sectionNumber,
    required this.bonusXp,
    super.key,
  });

  final int sectionNumber;
  final int bonusXp;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomDecoratedBox(
          gradient: AppColors.blueGradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueGradient.colors.last.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          child: SizedBox(
            width: double.infinity,
            height: 48.h,
            child: Row(
              children: [
                CustomDecoratedBox(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.surfaceLight,
                  opacity: 0.2,
                  child: SizedBox.square(
                    dimension: 48.r,
                    child: Icon(
                      Icons.emoji_events_rounded,
                      color: AppColors.secondaryLight,
                      size: 32.sp,
                    ),
                  ),
                ),
                16.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          context.l10n.sectionCleared(sectionNumber),
                          style: AppTextStyles.bodyLarge(context).copyWith(
                            color: AppColors.surfaceLight,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          context.l10n.bonusXpEarned(bonusXp),
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color:
                                AppColors.surfaceLight.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
