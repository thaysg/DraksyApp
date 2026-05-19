import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/intro_view_data.dart';
import 'intro_action_button.dart';
import 'intro_indicator.dart';
import 'intro_login_text.dart';
import 'intro_page_view.dart';

class IntroBody extends StatelessWidget {
  const IntroBody({
    required this.data,
    required this.controller,
    required this.onCompleteOnboarding,
    required this.onNext,
    required this.onPrevious,
    required this.onIndexChanged,
    required this.height,
    required this.firstHeightBox,
    required this.secondHeightBox,
    required this.thirdHeightBox,
    required this.fourthHeightBox,
    super.key,
  });

  final IntroViewData data;
  final PageController controller;
  final VoidCallback onCompleteOnboarding;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<int> onIndexChanged;
  final double height;
  final double firstHeightBox;
  final double secondHeightBox;
  final double thirdHeightBox;
  final double fourthHeightBox;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // Top: Skip button
          if (!data.isFirstPage)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  onCompleteOnboarding();
                  if (context.mounted) {
                    context.go(AppPaths.welcome);
                  }
                },
                child: Text(
                  data.isLastPage ? 'X' : context.l10n.skip,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.surfaceLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            firstHeightBox.heightBox,
          // Middle: PageView (centered)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height,
                    child: IntroPageView(
                      controller: controller,
                      onPageChanged: onIndexChanged,
                    ),
                  ),
                  secondHeightBox.heightBox,
                  IntroIndicator(currentIndex: data.currentIndex),
                ],
              ),
            ),
          ),
          // Bottom: Button + Login text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                IntroActionButton(
                  currentIndex: data.currentIndex,
                  onNext: onNext,
                  onPrevious: onPrevious,
                  onComplete: onCompleteOnboarding,
                ),
                thirdHeightBox.heightBox,
                IntroLoginText(visible: data.isFirstPage),
                fourthHeightBox.heightBox,
              ],
            ),
          ),
        ],
      );
}
