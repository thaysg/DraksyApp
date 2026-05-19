import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// UI-ready data for a lesson category.
class LessonCategoryData extends Equatable {
  const LessonCategoryData({
    required this.level,
    required this.title,
    required this.description,
    required this.progress,
    required this.timeInMinutes,
    required this.icon,
    required this.iconColor,
    this.isLocked = false,
  });

  final int level;
  final String title;
  final String description;
  final double progress;
  final int timeInMinutes;
  final IconData icon;
  final Color iconColor;
  final bool isLocked;

  static const mock = LessonCategoryData(
    level: 1,
    title: 'Category Title',
    description: 'Category description goes here',
    progress: 0.5,
    timeInMinutes: 10,
    icon: Icons.school,
    iconColor: AppColors.primaryAppColor,
  );

  @override
  List<Object?> get props => [
        level,
        title,
        description,
        progress,
        timeInMinutes,
        icon,
        iconColor,
        isLocked,
      ];
}

/// UI-ready data for the Lessons screen.
class LessonsViewData extends Equatable {
  const LessonsViewData({
    required this.lives,
    required this.gems,
    required this.categories,
  });

  final String lives;
  final String gems;
  final List<LessonCategoryData> categories;

  static final mock = LessonsViewData(
    lives: '5',
    gems: '100',
    categories: List.filled(3, LessonCategoryData.mock),
  );

  @override
  List<Object?> get props => [lives, gems, categories];
}
