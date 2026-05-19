import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// UI-ready data for a shop plan.
class ShopPlanData extends Equatable {
  const ShopPlanData({
    required this.title,
    required this.price,
    required this.period,
    required this.benefits,
    required this.buttonText,
    this.isHighlighted = false,
    this.badgeText,
  });

  final String title;
  final String price;
  final String period;
  final List<String> benefits;
  final String buttonText;
  final bool isHighlighted;
  final String? badgeText;

  static const mock = ShopPlanData(
    title: 'Plan Title',
    price: r'$0.00',
    period: '/ month',
    benefits: ['Benefit 1', 'Benefit 2'],
    buttonText: 'Action',
  );

  @override
  List<Object?> get props => [
        title,
        price,
        period,
        benefits,
        buttonText,
        isHighlighted,
        badgeText,
      ];
}

/// UI-ready data for a shop power-up.
class ShopPowerUpData extends Equatable {
  const ShopPowerUpData({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.price,
    required this.buttonText,
    this.showCounter = false,
    this.counterValue = 1,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String price;
  final String buttonText;
  final bool showCounter;
  final int counterValue;

  static const mock = ShopPowerUpData(
    title: 'Power-up',
    description: 'Description goes here',
    icon: Icons.bolt,
    iconColor: AppColors.primaryAppColor,
    price: '100',
    buttonText: 'Buy',
  );

  @override
  List<Object?> get props => [
        title,
        description,
        icon,
        iconColor,
        price,
        buttonText,
        showCounter,
        counterValue,
      ];
}

/// UI-ready data for the Shop screen.
class ShopViewData extends Equatable {
  const ShopViewData({
    required this.lives,
    required this.gems,
    required this.plans,
    required this.powerUps,
  });

  final String lives;
  final String gems;
  final List<ShopPlanData> plans;
  final List<ShopPowerUpData> powerUps;

  static final mock = ShopViewData(
    lives: '5',
    gems: '100',
    plans: List.filled(2, ShopPlanData.mock),
    powerUps: List.filled(2, ShopPowerUpData.mock),
  );

  @override
  List<Object?> get props => [lives, gems, plans, powerUps];
}
