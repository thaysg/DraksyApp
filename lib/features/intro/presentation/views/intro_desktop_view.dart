import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extension.dart';
import '../models/intro_view_data.dart';
import '../widgets/intro_body.dart';

class IntroDesktopView extends StatelessWidget {
  const IntroDesktopView({
    required this.data,
    required this.controller,
    required this.onCompleteOnboarding,
    required this.onNext,
    required this.onPrevious,
    required this.onIndexChanged,
    super.key,
  });

  final IntroViewData data;
  final PageController controller;
  final VoidCallback onCompleteOnboarding;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<int> onIndexChanged;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroBody(
          data: data,
          controller: controller,
          onCompleteOnboarding: onCompleteOnboarding,
          onNext: onNext,
          onPrevious: onPrevious,
          onIndexChanged: onIndexChanged,
          height: context.isLandscape ? 210.r : 250.r,
          firstHeightBox: 16,
          secondHeightBox: 40,
          thirdHeightBox: 16,
          fourthHeightBox: 24,
        ),
      );
}
