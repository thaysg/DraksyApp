import 'package:flutter/material.dart';

import '../../../../../core/extensions/spacing.dart';
import 'profile_actions_card.dart';
import 'profile_notifications_card.dart';
import 'profile_settings_card.dart';
import 'profile_support_card.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.onLogout,
    required this.onDeleteAccount,
    super.key,
  });

  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileActionsCard(),
          16.heightBox,
          const ProfileNotificationsCard(),
          16.heightBox,
          const ProfileSettingsCard(),
          16.heightBox,
          ProfileSupportCard(
            onLogout: onLogout,
            onDeleteAccount: onDeleteAccount,
          ),
        ],
      );
}
