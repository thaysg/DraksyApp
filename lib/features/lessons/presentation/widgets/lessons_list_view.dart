import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/lesson_unit_data.dart';
import 'lesson_path_node.dart';
import 'lesson_section_cleared_banner.dart';

class LessonsListViewItem extends StatelessWidget {
  const LessonsListViewItem({
    required this.unit,
    required this.index,
    required this.nodeVerticalSpacing,
    this.isLast = false,
    super.key,
  });

  final LessonUnitData unit;
  final int index;
  final double nodeVerticalSpacing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isLeft = index % 2 != 0;
    final nodeRowHeight = 96.r;

    return Column(
      children: [
        SizedBox(
          height: nodeRowHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment:
                  isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                if (!isLeft) ...[
                  Text(
                    context.l10n.unitNumber(unit.unitNumber),
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  16.widthBox,
                ],
                LessonPathNode(
                  unitNumber: unit.unitNumber,
                  state: unit.state,
                  onTap: () => context.pushNamed(
                    AppRoutes.lessonDetail,
                    pathParameters: {
                      'unitId': unit.id,
                      'lessonId': unit.lessonId,
                      'title': unit.title,
                    },
                  ),
                ),
                if (isLeft) ...[
                  16.widthBox,
                  Text(
                    context.l10n.unitNumber(unit.unitNumber),
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (unit.unitNumber % 12 == 0 && !isLast)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: LessonSectionClearedBanner(
              sectionNumber: (unit.unitNumber / 12).floor(),
              bonusXp: 50,
            ),
          )
        else if (!isLast)
          SizedBox(height: nodeVerticalSpacing - nodeRowHeight),
      ],
    );
  }
}
