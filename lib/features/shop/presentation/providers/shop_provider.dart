import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/shop_view_data.dart';

part 'shop_provider.g.dart';

@riverpod
Future<ShopViewData> shopView(Ref ref) async => const ShopViewData(
      lives: 'Full',
      gems: '450',
      plans: [
        ShopPlanData(
          title: 'Annual Plan',
          price: r'$59.99',
          period: '/ year',
          badgeText: 'BEST VALUE',
          isHighlighted: true,
          benefits: [
            'Unlimited Hearts',
            'No Ads',
            'Offline Access',
            'Monthly Streak Repair',
          ],
          buttonText: 'Start Free Trial',
        ),
        ShopPlanData(
          title: 'Monthly Plan',
          price: r'$9.99',
          period: '/ month',
          isHighlighted: false,
          benefits: [
            'Unlimited Hearts',
            'No Ads',
          ],
          buttonText: 'Subscribe Monthly',
        ),
      ],
      powerUps: [
        ShopPowerUpData(
          title: 'Refill Hearts',
          description: 'Get back in the game',
          icon: Icons.favorite_rounded,
          iconColor: AppColors.primaryAppColor,
          price: '350',
          buttonText: 'Purchase',
          showCounter: true,
          counterValue: 5,
        ),
        ShopPowerUpData(
          title: 'Streak Freeze',
          description: 'Protect your streak',
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.info,
          price: '200',
          buttonText: 'Buy',
        ),
      ],
    );
