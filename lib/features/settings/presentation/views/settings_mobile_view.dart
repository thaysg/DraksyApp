import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../models/settings_view_data.dart';
import '../widgets/settings_general_card.dart';
import '../widgets/settings_learning_card.dart';
import '../widgets/settings_notifications_card.dart';
import '../widgets/settings_preferences_card.dart';

class SettingsMobileView extends StatelessWidget {
  const SettingsMobileView({
    required this.data,
    required this.onToggleTheme,
    super.key,
  });

  final SettingsViewData data;
  final ValueChanged<bool> onToggleTheme;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsGeneralCard(email: data.email),
            24.heightBox,
            SettingsLearningCard(
              dailyGoalXp: data.dailyGoalXp,
              reminderTime: data.reminderTime,
            ),
            24.heightBox,
            SettingsNotificationsCard(
              isSoundEnabled: data.isSoundEnabled,
              voiceSpeed: data.voiceSpeed,
            ),
            24.heightBox,
            SettingsPreferencesCard(
              themeMode: data.themeMode,
              isHapticsEnabled: data.isHapticsEnabled,
              onToggleTheme: onToggleTheme,
            ),
            40.heightBox,
          ],
        ),
      );
}
