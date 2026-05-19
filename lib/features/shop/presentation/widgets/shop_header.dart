import 'package:flutter/material.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/header_page.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({
    required this.lives,
    required this.gems,
    super.key,
  });

  final String lives;
  final String gems;

  @override
  Widget build(BuildContext context) => HeaderPage(
        hasRow: true,
        iconWidget: Image.asset(
          AppIcons.shoppingBag,
          width: 32,
          height: 32,
          color: AppColors.surfaceLight,
        ),
        title: context.l10n.shop,
        icon1: Icons.favorite_rounded,
        iconColor1: AppColors.primaryAppColor,
        valueColor1: AppColors.primaryAppColor,
        valueText1: lives == 'Full' ? context.l10n.livesFull : lives,
        icon2: Icons.stars_rounded,
        iconColor2: AppColors.gold,
        valueText2: gems,
      );
}
