import 'package:flutter/material.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/header_page.dart';

class LessonsHeader extends StatelessWidget {
  const LessonsHeader({
    required this.lives,
    required this.gems,
    super.key,
  });

  final String lives;
  final String gems;

  @override
  Widget build(BuildContext context) => HeaderPage(
        hasRow: true,
        iconWidget: const Icon(
          Icons.layers_rounded,
          color: AppColors.backgroundLight,
        ),
        title: context.l10n.lessons,
        icon1: Icons.favorite_rounded,
        iconColor1: AppColors.primaryAppColor,
        valueColor1: AppColors.primaryAppColor,
        valueText1: lives == 'Full' ? context.l10n.livesFull : lives,
        icon2: Icons.toll,
        iconColor2: AppColors.secondaryLight,
        valueText2: gems,
      );
}
