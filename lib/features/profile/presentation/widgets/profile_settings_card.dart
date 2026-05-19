import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../../core/widgets/custom_list_tile.dart';

class ProfileSettingsCard extends StatelessWidget {
  const ProfileSettingsCard({super.key});

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: CustomListTile(
          title: context.l10n.settings,
          icon: Icons.settings_rounded,
          iconColor: AppColors.textSecondary(context),
          onTap: () => context.pushNamed(AppRoutes.settings),
        ),
      );
}
