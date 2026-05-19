import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/section_header.dart';
import '../models/shop_view_data.dart';
import 'product_grid.dart';
import 'shop_plan_card.dart';

class ShopPlansSection extends StatelessWidget {
  const ShopPlansSection({
    required this.plans,
    super.key,
  });

  final List<ShopPlanData> plans;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.premiumMembership,
            icon: Icons.workspace_premium_rounded,
            iconColor: AppColors.purple,
          ),
          16.heightBox,
          ProductGrid(
            desktopChildAspectRatio: 0.7,
            tabletChildAspectRatio: 0.6,
            mobileChildAspectRatio: 1,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: plans
                .map((plan) => ShopPlanCard(
                      title: plan.title,
                      price: plan.price,
                      period: plan.period,
                      badgeText: plan.badgeText,
                      isHighlighted: plan.isHighlighted,
                      benefits: plan.benefits,
                      buttonText: plan.buttonText,
                      onPressed: () {},
                    ))
                .toList(),
          ),
        ],
      );
}
