import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/widgets/custom_scroll.dart';
import '../../models/lessons_view_data.dart';
import '../../widgets/lesson_category_card.dart';
import '../../widgets/lesson_filter_chip.dart';
import '../../widgets/lessons_header.dart';

class LessonsMobileView extends StatelessWidget {
  const LessonsMobileView({required this.data, super.key});

  final LessonsViewData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LessonsHeader(lives: data.lives, gems: data.gems),
          20.heightBox,

          // Categories Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                LessonFilterChip(
                  label: l10n.allCategories,
                  isSelected: true,
                ),
                12.widthBox,
                LessonFilterChip(
                  label: l10n.grammar,
                  isSelected: false,
                ),
                12.widthBox,
                LessonFilterChip(
                  label: l10n.vocabulary,
                  isSelected: false,
                ),
              ],
            ),
          ),
          32.heightBox,

          // Lesson Categories
          ...data.categories.map((category) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: LessonCategoryCard(
                  level: category.level,
                  title: category.title,
                  description: category.description,
                  progress: category.progress,
                  time: l10n.timePerLesson(category.timeInMinutes),
                  icon: category.icon,
                  iconColor: category.iconColor,
                  isLocked: category.isLocked,
                  onTap: category.isLocked
                      ? () {}
                      : () => context.pushNamed(
                            AppRoutes.lessonPath,
                            pathParameters: {'title': category.title},
                          ),
                ),
              )),
          100.heightBox,
        ],
      ),
    );
  }
}
