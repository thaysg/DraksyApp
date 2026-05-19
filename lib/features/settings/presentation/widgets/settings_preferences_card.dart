import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/section_header.dart';
import 'settings_item.dart';

class SettingsPreferencesCard extends StatelessWidget {
  const SettingsPreferencesCard({
    required this.themeMode,
    required this.isHapticsEnabled,
    required this.onToggleTheme,
    super.key,
  });

  final ThemeMode themeMode;
  final bool isHapticsEnabled;
  final ValueChanged<bool> onToggleTheme;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.preferences,
          ),
          12.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsItem(
                  title: context.l10n.darkMode,
                  icon: Icons.dark_mode_rounded,
                  iconColor: AppColors.primaryAppColor,
                  trailing: Switch(
                    value: themeMode == ThemeMode.dark,
                    onChanged: onToggleTheme,
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
                  title: context.l10n.haptics,
                  icon: Icons.vibration_rounded,
                  iconColor: AppColors.secondaryLight,
                  trailing: Switch(
                    value: isHapticsEnabled,
                    onChanged: (value) {},
                    activeThumbColor: AppColors.primaryAppColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
