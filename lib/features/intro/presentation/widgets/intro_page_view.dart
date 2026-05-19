import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/localization_extension.dart';
import 'intro_card.dart';

class IntroPageView extends StatelessWidget {
  const IntroPageView({
    required this.controller,
    required this.onPageChanged,
    super.key,
  });

  final PageController controller;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) => PageView(
        controller: controller,
        onPageChanged: onPageChanged,
        children: [
          IntroCard(
            image: AppImages.splash,
            title: context.l10n.introTitle1,
            subtitle: context.l10n.introSubtitle1,
          ),
          IntroCard(
            image: AppImages.dragonBlueFlying,
            title: context.l10n.introTitle2,
            subtitle: context.l10n.introSubtitle2,
          ),
          IntroCard(
            image: AppImages.dragonGreenWinking,
            title: context.l10n.introTitle3,
            subtitle: context.l10n.introSubtitle3,
          ),
          IntroCard(
            image: AppImages.dragonPurpleLaughing,
            title: context.l10n.introTitle4,
            subtitle: context.l10n.introSubtitle4,
          ),
        ],
      );
}
