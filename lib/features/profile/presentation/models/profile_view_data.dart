import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// UI-ready data for a profile badge.
class ProfileBadgeData extends Equatable {
  const ProfileBadgeData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  static const mock = ProfileBadgeData(
    title: 'Badge Title',
    subtitle: 'Badge Subtitle',
    icon: Icons.workspace_premium,
    color: AppColors.gold,
  );

  @override
  List<Object?> get props => [title, subtitle, icon, color];
}

/// UI-ready data for a profile language.
class ProfileLanguageData extends Equatable {
  const ProfileLanguageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  static const mock = ProfileLanguageData(
    title: 'Language',
    subtitle: 'Beginner • 0%',
    icon: Icons.language,
    color: AppColors.primaryAppColor,
  );

  @override
  List<Object?> get props => [title, subtitle, icon, color];
}

/// UI-ready data for the Profile screen.
class ProfileViewData extends Equatable {
  const ProfileViewData({
    required this.userName,
    required this.userTag,
    required this.email,
    required this.photo,
    required this.bio,
    required this.level,
    required this.totalXp,
    required this.streak,
    required this.lessons,
    required this.accuracy,
    required this.currentXp,
    required this.maxXp,
    required this.badges,
    required this.languages,
  });

  final String userName;
  final String userTag;
  final String email;
  final String photo;
  final String bio;
  final int level;
  final String totalXp;
  final int streak;
  final int lessons;
  final String accuracy;
  final int currentXp;
  final int maxXp;
  final List<ProfileBadgeData> badges;
  final List<ProfileLanguageData> languages;

  static final mock = ProfileViewData(
    userName: 'User Name',
    userTag: '@username',
    email: 'user@example.com',
    photo: '',
    bio: '',
    level: 1,
    totalXp: '0',
    streak: 0,
    lessons: 0,
    accuracy: '0%',
    currentXp: 0,
    maxXp: 100,
    badges: List.filled(3, ProfileBadgeData.mock),
    languages: List.filled(2, ProfileLanguageData.mock),
  );

  @override
  List<Object?> get props => [
        userName,
        userTag,
        email,
        photo,
        bio,
        level,
        totalXp,
        streak,
        lessons,
        accuracy,
        currentXp,
        maxXp,
        badges,
        languages,
      ];
}
