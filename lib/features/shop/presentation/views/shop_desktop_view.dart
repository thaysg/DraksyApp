import 'package:flutter/material.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/widgets/custom_scroll.dart';
import '../models/shop_view_data.dart';
import '../widgets/shop_header.dart';
import '../widgets/shop_plans_section.dart';
import '../widgets/shop_power_ups_section.dart';
import '../widgets/shop_sidebar.dart';

class ShopDesktopView extends StatelessWidget {
  const ShopDesktopView({required this.data, super.key});

  final ShopViewData data;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShopSidebar(),
            48.widthBox,
            // Main Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopHeader(lives: data.lives, gems: data.gems),
                  48.heightBox,
                  ShopPlansSection(plans: data.plans),
                  48.heightBox,
                  ShopPowerUpsSection(powerUps: data.powerUps),
                  100.heightBox,
                ],
              ),
            ),
          ],
        ),
      );
}
