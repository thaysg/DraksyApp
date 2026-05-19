import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/section_header.dart';
import 'settings_item.dart';

class SettingsNotificationsCard extends StatelessWidget {
  const SettingsNotificationsCard({
    required this.isSoundEnabled,
    required this.voiceSpeed,
    super.key,
  });

  final bool isSoundEnabled;
  final String voiceSpeed;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.audio,
          ),
          12.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsItem(
                  title: context.l10n.soundEffects,
                  icon: Icons.volume_up_rounded,
                  iconColor: AppColors.mana,
                  trailing: Switch(
                    value: isSoundEnabled,
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
                  title: context.l10n.voiceSpeed,
                  subtitle: voiceSpeed,
                  icon: Icons.speed_rounded,
                  iconColor: AppColors.textSecondary(context),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      );
}
