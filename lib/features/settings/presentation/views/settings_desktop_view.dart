import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../models/settings_view_data.dart';
import '../widgets/settings_general_card.dart';
import '../widgets/settings_learning_card.dart';
import '../widgets/settings_notifications_card.dart';
import '../widgets/settings_preferences_card.dart';

class SettingsDesktopView extends StatelessWidget {
  const SettingsDesktopView({
    required this.data,
    required this.onToggleTheme,
    super.key,
  });

  final SettingsViewData data;
  final ValueChanged<bool> onToggleTheme;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppResponsive.maxContentWidth(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SettingsGeneralCard(email: data.email),
                          32.heightBox,
                          SettingsLearningCard(
                            dailyGoalXp: data.dailyGoalXp,
                            reminderTime: data.reminderTime,
                          ),
                        ],
                      ),
                    ),
                    40.widthBox,
                    Expanded(
                      child: Column(
                        children: [
                          SettingsNotificationsCard(
                            isSoundEnabled: data.isSoundEnabled,
                            voiceSpeed: data.voiceSpeed,
                          ),
                          32.heightBox,
                          SettingsPreferencesCard(
                            themeMode: data.themeMode,
                            isHapticsEnabled: data.isHapticsEnabled,
                            onToggleTheme: onToggleTheme,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                100.heightBox,
              ],
            ),
          ),
        ),
      );
}
