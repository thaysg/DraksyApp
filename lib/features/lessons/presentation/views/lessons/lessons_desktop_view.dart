import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/responsive/app_responsive.dart';
import '../../../../../core/widgets/custom_scroll.dart';
import '../../models/lessons_view_data.dart';
import '../../widgets/lesson_category_card.dart';
import '../../widgets/lesson_filter_chip.dart';
import '../../widgets/lessons_header.dart';

class LessonsDesktopView extends StatelessWidget {
  const LessonsDesktopView({required this.data, super.key});

  final LessonsViewData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomScroll(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.maxContentWidth(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LessonsHeader(lives: data.lives, gems: data.gems),
              32.heightBox,

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
              48.heightBox,

              // Lesson Categories Grid
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.75,
                children: data.categories
                    .map((category) => LessonCategoryCard(
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
                        ))
                    .toList(),
              ),
              100.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
