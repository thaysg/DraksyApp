import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/section_header.dart';
import 'settings_item.dart';

class SettingsLearningCard extends StatelessWidget {
  const SettingsLearningCard({
    required this.dailyGoalXp,
    required this.reminderTime,
    super.key,
  });

  final int dailyGoalXp;
  final String reminderTime;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.learningGoals,
          ),
          12.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsItem(
                  title: context.l10n.dailyGoal,
                  subtitle: context.l10n.xpPerDay(dailyGoalXp),
                  icon: Icons.track_changes_rounded,
                  iconColor: AppColors.gold,
                  onTap: () {},
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 64,
                  endIndent: 16,
                  color:
                      AppColors.textSecondary(context).withValues(alpha: 0.1),
                ),
                SettingsItem(
                  title: context.l10n.practiceReminders,
                  subtitle: context.l10n.dailyAt(reminderTime),
                  icon: Icons.notifications_active_rounded,
                  iconColor: AppColors.primaryAppColor,
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeThumbColor: AppColors.primaryAppColor,
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 64,
                  endIndent: 16,
                  color:
                      AppColors.textSecondary(context).withValues(alpha: 0.1),
                ),
                SettingsItem(
                  title: context.l10n.difficulty,
                  subtitle: context.l10n.intermediate,
                  icon: Icons.speed_rounded,
                  iconColor: AppColors.success,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      );
}
