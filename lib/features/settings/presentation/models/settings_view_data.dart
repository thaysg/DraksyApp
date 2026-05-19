import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// UI-ready data for the Settings screen.
class SettingsViewData extends Equatable {
  const SettingsViewData({
    required this.email,
    required this.dailyGoalXp,
    required this.reminderTime,
    required this.isSoundEnabled,
    required this.voiceSpeed,
    required this.themeMode,
    required this.isHapticsEnabled,
  });

  final String email;
  final int dailyGoalXp;
  final String reminderTime;
  final bool isSoundEnabled;
  final String voiceSpeed;
  final ThemeMode themeMode;
  final bool isHapticsEnabled;

  @override
  List<Object?> get props => [
        email,
        dailyGoalXp,
        reminderTime,
        isSoundEnabled,
        voiceSpeed,
        themeMode,
        isHapticsEnabled,
      ];
}
