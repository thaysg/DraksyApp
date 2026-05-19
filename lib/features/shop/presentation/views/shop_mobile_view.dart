import 'package:flutter/material.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/widgets/custom_scroll.dart';
import '../models/shop_view_data.dart';
import '../widgets/shop_header.dart';
import '../widgets/shop_plans_section.dart';
import '../widgets/shop_power_ups_section.dart';

class ShopMobileView extends StatelessWidget {
  const ShopMobileView({required this.data, super.key});

  final ShopViewData data;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShopHeader(lives: data.lives, gems: data.gems),
            32.heightBox,
            ShopPlansSection(plans: data.plans),
            32.heightBox,
            ShopPowerUpsSection(powerUps: data.powerUps),
            80.heightBox,
          ],
        ),
      );
}
