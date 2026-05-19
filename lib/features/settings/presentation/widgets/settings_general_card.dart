import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/section_header.dart';
import 'settings_item.dart';

class SettingsGeneralCard extends StatelessWidget {
  const SettingsGeneralCard({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.account,
          ),
          12.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsItem(
                  title: context.l10n.email,
                  subtitle: email,
                  icon: Icons.email_rounded,
                  iconColor: AppColors.purple,
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
                  title: context.l10n.password,
                  subtitle: context.l10n.changePassword,
                  icon: Icons.lock_rounded,
                  iconColor: AppColors.textSecondary(context),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      );
}
