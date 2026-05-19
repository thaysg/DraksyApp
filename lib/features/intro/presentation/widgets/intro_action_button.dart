import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class IntroActionButton extends StatelessWidget {
  const IntroActionButton({
    required this.currentIndex,
    required this.onNext,
    required this.onPrevious,
    required this.onComplete,
    super.key,
  });

  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final isFirstPage = currentIndex == 0;
    final isLastPage = currentIndex == 3;

    // Primeira página: botão grande centrado
    if (isFirstPage) {
      return CustomButton(
        text: context.l10n.introGetStarted,
        onPressed: onNext,
        width: double.infinity,
        icon: Icons.chevron_right_rounded,
        iconTrailing: true,
        type: ButtonType.outlined,
        textColor: AppColors.backgroundDark,
        outlineStyle: OutlinedButton.styleFrom(
          backgroundColor: AppColors.backgroundLight,
        ),
      );
    }

    // Páginas 2-4: botão anterior + próximo/Get Started
    return Row(
      children: [
        IconButton(
          onPressed: onPrevious,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceLight.withValues(alpha: 0.2),
            padding: const EdgeInsets.all(16),
          ),
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.surfaceLight,
          ),
        ),
        16.widthBox,
        Expanded(
          child: CustomButton(
            text: isLastPage ? context.l10n.introGetStarted : context.l10n.next,
            onPressed: () async {
              if (isLastPage) {
                onComplete();
                if (context.mounted) {
                  context.go(AppPaths.welcome);
                }
              } else {
                onNext();
              }
            },
            width: double.infinity,
            icon: isLastPage
                ? Icons.favorite_rounded
                : Icons.chevron_right_rounded,
            iconTrailing: true,
            type: ButtonType.outlined,
            textColor: AppColors.backgroundDark,
            outlineStyle: OutlinedButton.styleFrom(
              backgroundColor: AppColors.backgroundLight,
            ),
          ),
        ),
      ],
    );
  }
}
