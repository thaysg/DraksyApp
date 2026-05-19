import 'package:flutter/material.dart';

import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/xp_bar.dart';
import '../../../../core/widgets/section_header.dart';
import 'profile_stat_item.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({
    required this.totalXp,
    required this.streak,
    required this.lessons,
    required this.accuracy,
    required this.currentXp,
    required this.maxXp,
    super.key,
  });

  final String totalXp;
  final int streak;
  final int lessons;
  final String accuracy;
  final int currentXp;
  final int maxXp;

  @override
  Widget build(BuildContext context) {
    final stats = [
      ProfileStatItem(
        label: context.l10n.totalXp,
        value: totalXp,
        icon: Icons.bolt_rounded,
        color: AppColors.secondaryDark,
        child: XpBar(
          currentXp: currentXp,
          maxXp: maxXp,
          showLabel: false,
          height: 6,
          gradient: AppColors.xpBarGradient,
        ),
      ),
      ProfileStatItem(
        label: context.l10n.streak,
        value: streak.toString(),
        icon: Icons.local_fire_department_rounded,
        color: AppColors.secondaryLight,
      ),
      ProfileStatItem(
        label: context.l10n.lessons,
        value: lessons.toString(),
        icon: Icons.menu_book_rounded,
        color: AppColors.purple,
      ),
      ProfileStatItem(
        label: context.l10n.accuracy,
        value: accuracy,
        icon: Icons.track_changes_rounded,
        color: AppColors.success,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: context.l10n.learningStats,
        ),
        16.heightBox,
        if (!context.isMobile)
          IntrinsicHeight(
            child: Row(
              children: [
                for (var i = 0; i < stats.length; i++) ...[
                  Expanded(child: stats[i]),
                  if (i < stats.length - 1) 12.widthBox,
                ],
              ],
            ),
          )
        else
          GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: stats,
          ),
      ],
    );
  }
}
