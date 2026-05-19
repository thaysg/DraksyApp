import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/fade_in_widget.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Draksy full image or logo
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1),
              duration: const Duration(seconds: 1),
              curve: Curves.elasticOut,
              builder: (context, value, child) => Transform.scale(
                scale: value,
                child: child,
              ),
              child: Image.asset(
                AppImages.splash,
                width: 200,
                height: 200,
              ),
            ),
            24.heightBox,
            // App Name
            FadeInWidget(
              duration: const Duration(milliseconds: 800),
              child: Text(
                context.l10n.appName,
                style: AppTextStyles.h1(context).copyWith(
                  color: AppColors.textPrimaryDark,
                  fontSize: 40,
                ),
              ),
            ),
            16.heightBox,
            // Tagline
            FadeInWidget(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 400),
              child: Text(
                context.l10n.welcome,
                style: AppTextStyles.bodyLarge(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
            64.heightBox,
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
            ),
          ],
        ),
      );
}
