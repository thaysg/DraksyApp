import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/header_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.userName,
    required this.streak,
    required this.userPhotoUrl,
    super.key,
  });

  final String userName;
  final String streak;

  /// Nullable — when null the app logo is used as the icon.
  final String? userPhotoUrl;

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? context.l10n.goodMorning
        : hour < 18
            ? context.l10n.goodAfternoon
            : context.l10n.goodEvening;

    final icon = userPhotoUrl != null
        ? ClipOval(
            child: Image.network(
              userPhotoUrl!,
              width: 32.r,
              height: 32.r,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                AppImages.logo,
                width: 32.r,
                height: 32.r,
                color: AppColors.surfaceLight,
              ),
            ),
          )
        : Image.asset(
            AppImages.logo,
            width: 32.r,
            height: 32.r,
            color: AppColors.surfaceLight,
          );

    return HeaderPage(
      iconWidget: icon,
      hasColumn: true,
      title: greeting,
      subtitle: userName,
      icon1: Icons.local_fire_department,
      iconColor1: AppColors.accent,
      valueText1: streak,
    );
  }
}
