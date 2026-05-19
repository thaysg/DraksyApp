import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bottom_bar/stylish_bottom_bar.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });
  final int selectedIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) => StylishBottomBar(
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        notchStyle: NotchStyle.circle,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        backgroundColor: context.isDarkMode
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        option: AnimatedBarOptions(
          iconSize: 26,
          iconStyle: IconStyle.animated,
          padding: const EdgeInsets.symmetric(vertical: 6),
        ),
        items: [
          BottomBarItem(
            icon: Image.asset(
              AppIcons.home,
              width: 24,
              height: 24,
              color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
            ),
            selectedIcon: Image.asset(
              AppIcons.home,
              width: 24,
              height: 24,
              color: AppColors.primaryAppColor,
            ),
            selectedColor: AppColors.primaryAppColor,
            unSelectedColor: AppColors.textSecondaryLight,
            title: Text(
              context.l10n.home.toUpperCase(),
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w900,
                color: (selectedIndex == 0 || selectedIndex == 2)
                    ? AppColors.primaryAppColor
                    : AppColors.textSecondaryLight.withValues(alpha: 0.7),
                fontSize: 8.sp,
                letterSpacing: 0.2,
              ),
            ),
          ),
          BottomBarItem(
            icon: Image.asset(
              AppIcons.feed,
              width: 24,
              height: 24,
              color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
            ),
            selectedIcon: Image.asset(
              AppIcons.feed,
              width: 24,
              height: 24,
              color: AppColors.primaryAppColor,
            ),
            selectedColor: AppColors.primaryAppColor,
            unSelectedColor:
                AppColors.textSecondaryLight.withValues(alpha: 0.7),
            title: Text(
              context.l10n.feedTitle.toUpperCase(),
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w900,
                color: selectedIndex == 1
                    ? AppColors.primaryAppColor
                    : AppColors.textSecondaryLight.withValues(alpha: 0.7),
                fontSize: 8.sp,
                letterSpacing: 0.2,
              ),
            ),
          ),
          BottomBarItem(
            icon: Image.asset(
              AppIcons.shoppingBag,
              width: 24,
              height: 24,
              color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
            ),
            selectedIcon: Image.asset(
              AppIcons.shoppingBag,
              width: 24,
              height: 24,
              color: AppColors.primaryAppColor,
            ),
            selectedColor: AppColors.primaryAppColor,
            unSelectedColor:
                AppColors.textSecondaryLight.withValues(alpha: 0.7),
            title: Text(
              context.l10n.shop.toUpperCase(),
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w900,
                color: selectedIndex == 3
                    ? AppColors.primaryAppColor
                    : AppColors.textSecondaryLight.withValues(alpha: 0.7),
                fontSize: 8.sp,
                letterSpacing: 0.2,
              ),
            ),
          ),
          BottomBarItem(
            icon: Image.asset(
              AppIcons.user,
              width: 24,
              height: 24,
              color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
            ),
            selectedIcon: Image.asset(
              AppIcons.user,
              width: 24,
              height: 24,
              color: AppColors.primaryAppColor,
            ),
            selectedColor: AppColors.primaryAppColor,
            unSelectedColor:
                AppColors.textSecondaryLight.withValues(alpha: 0.7),
            title: Text(
              context.l10n.profile.toUpperCase(),
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w900,
                color: selectedIndex == 4
                    ? AppColors.primaryAppColor
                    : AppColors.textSecondaryLight.withValues(alpha: 0.7),
                fontSize: 8.sp,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
        currentIndex: selectedIndex == 2
            ? 0 // visual fallback
            : (selectedIndex > 2 ? selectedIndex - 1 : selectedIndex),
        onTap: onTap,
      );
}
