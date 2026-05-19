import 'package:flutter/material.dart';

import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import 'shop_sidebar_item.dart';

class ShopSidebar extends StatelessWidget {
  const ShopSidebar({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.categories,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            24.heightBox,
            ShopSidebarItem(
              icon: Icons.star_rounded,
              label: context.l10n.featured,
              isSelected: true,
            ),
            ShopSidebarItem(
              icon: Icons.workspace_premium_rounded,
              label: context.l10n.premiumMembership,
              isSelected: false,
            ),
            ShopSidebarItem(
              icon: Icons.favorite_rounded,
              label: context.l10n.powerUps,
              isSelected: false,
            ),
            ShopSidebarItem(
              icon: Icons.auto_awesome_rounded,
              label: context.l10n.specials,
              isSelected: false,
            ),
          ],
        ),
      );
}
