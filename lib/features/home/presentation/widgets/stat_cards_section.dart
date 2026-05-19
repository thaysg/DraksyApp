import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import 'stat_item.dart';
import 'stat_vertical_divider.dart';

class StatCardsSection extends StatelessWidget {
  const StatCardsSection({
    required this.xp,
    required this.level,
    required this.lives,
    super.key,
  });
  final String xp;
  final String level;
  final String lives;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: context.isMobile ? 8 : 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatItem(
              icon: Icons.stars_rounded,
              iconColor: AppColors.gold,
              label: context.l10n.xp,
              value: xp,
            ),
            const StatVerticalDivider(),
            StatItem(
              icon: Icons.workspace_premium_rounded,
              iconColor: AppColors.purple,
              label: context.l10n.levels, // Or add "Level" to l10n
              value: level,
            ),
            const StatVerticalDivider(),
            StatItem(
              icon: Icons.favorite_rounded,
              iconColor: AppColors.primaryAppColor,
              label: context.l10n.lives,
              value: lives == 'Full' ? context.l10n.livesFull : lives,
              valueColor: lives == 'Full' ? AppColors.primaryAppColor : null,
            ),
          ],
        ),
      );
}
