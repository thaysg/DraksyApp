import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../../core/widgets/custom_list_tile.dart';

class ProfileNotificationsCard extends StatelessWidget {
  const ProfileNotificationsCard({super.key});

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: CustomListTile(
          title: context.l10n.notifications,
          icon: Icons.notifications_active_rounded,
          iconColor: AppColors.primaryAppColor,
          onTap: () {},
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeThumbColor: AppColors.primaryAppColor,
          ),
        ),
      );
}
