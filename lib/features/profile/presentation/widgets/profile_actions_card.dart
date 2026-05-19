import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../../core/widgets/custom_list_tile.dart';

class ProfileActionsCard extends StatelessWidget {
  const ProfileActionsCard({super.key});

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            CustomListTile(
              title: context.l10n.draksyPremium,
              subtitle: context.l10n.manageSubscription,
              icon: Icons.stars_rounded,
              iconColor: AppColors.primaryAppColor,
              onTap: () {},
            ),
            Divider(
              height: 1,
              color: AppColors.surface(context).withValues(alpha: 0.1),
              indent: 72,
            ),
            CustomListTile(
              title: context.l10n.inviteFriends,
              subtitle: context.l10n.inviteFriendsReward,
              icon: Icons.person_add_rounded,
              iconColor: AppColors.purple,
              onTap: () {},
            ),
            Divider(
              height: 1,
              color: AppColors.surface(context).withValues(alpha: 0.1),
              indent: 72,
            ),
            CustomListTile(
              title: context.l10n.helpSupport,
              subtitle: context.l10n.faqContact,
              icon: Icons.help_outline_rounded,
              iconColor: AppColors.textSecondary(context),
              onTap: () {},
            ),
            Divider(
              height: 1,
              color: AppColors.surface(context).withValues(alpha: 0.1),
              indent: 72,
            ),
            CustomListTile(
              title: context.l10n.progressHistory,
              subtitle: context.l10n.viewAllCompletedLessons,
              icon: Icons.history_rounded,
              iconColor: AppColors.secondaryLight,
              onTap: () => context.pushNamed(AppRoutes.progressHistory),
            ),
          ],
        ),
      );
}
