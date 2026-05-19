import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// UI-ready data for a lesson in the Home screen.
class HomeLessonData extends Equatable {
  const HomeLessonData({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.progress,
    required this.iconBgColor,
  });

  final String title;
  final String subtitle;
  final String emoji;
  final double progress;
  final Color iconBgColor;

  static const mock = HomeLessonData(
    title: 'Lesson Title',
    subtitle: 'Unit 1, Lesson 1',
    emoji: '📚',
    progress: 0.5,
    iconBgColor: AppColors.textSecondaryLight,
  );

  @override
  List<Object?> get props => [title, subtitle, emoji, progress, iconBgColor];
}

/// UI-ready data for the daily challenge in the Home screen.
class HomeDailyChallengeData extends Equatable {
  const HomeDailyChallengeData({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.lessonsCompleted,
  });

  final String title;
  final String subtitle;
  final double progress;
  final int lessonsCompleted;

  static const mock = HomeDailyChallengeData(
    title: 'Daily Challenge Title',
    subtitle: 'Daily Challenge Subtitle',
    progress: 0.5,
    lessonsCompleted: 2,
  );

  @override
  List<Object?> get props => [title, subtitle, progress, lessonsCompleted];
}

/// UI-ready data for the Home screen.
class HomeViewData extends Equatable {
  const HomeViewData({
    required this.userName,
    required this.userPhotoUrl,
    required this.xp,
    required this.level,
    required this.lives,
    required this.streak,
    required this.dailyChallenge,
    required this.lessons,
  });

  final String userName;

  /// Nullable — when null the header falls back to the app logo.
  final String? userPhotoUrl;

  final String xp;
  final String level;
  final String lives;
  final String streak;
  final HomeDailyChallengeData dailyChallenge;
  final List<HomeLessonData> lessons;

  static final mock = HomeViewData(
    userName: 'User Name',
    userPhotoUrl: null,
    xp: '1000',
    level: '1',
    lives: '5',
    streak: '0',
    dailyChallenge: HomeDailyChallengeData.mock,
    lessons: List.filled(3, HomeLessonData.mock),
  );

  @override
  List<Object?> get props => [
        userName,
        userPhotoUrl,
        xp,
        level,
        lives,
        streak,
        dailyChallenge,
        lessons,
      ];
}
