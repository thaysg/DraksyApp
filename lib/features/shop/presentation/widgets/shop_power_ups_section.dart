import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/section_header.dart';
import '../models/shop_view_data.dart';
import 'product_grid.dart';
import 'shop_power_up_item.dart';

class ShopPowerUpsSection extends StatelessWidget {
  const ShopPowerUpsSection({
    required this.powerUps,
    super.key,
  });

  final List<ShopPowerUpData> powerUps;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.powerUps,
            icon: Icons.favorite_rounded,
            iconColor: AppColors.primaryAppColor,
          ),
          16.heightBox,
          ProductGrid(
            desktopChildAspectRatio: 1,
            tabletChildAspectRatio: 0.9,
            mobileChildAspectRatio: 1.7,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: powerUps
                .map((powerUp) => ShopPowerUpItem(
                      title: powerUp.title,
                      description: powerUp.description,
                      icon: powerUp.icon,
                      iconColor: powerUp.iconColor,
                      price: powerUp.price,
                      buttonText: powerUp.buttonText,
                      showCounter: powerUp.showCounter,
                      counterValue: powerUp.counterValue,
                      onPressed: () {},
                    ))
                .toList(),
          ),
        ],
      );
}
