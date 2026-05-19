import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/intro_view_data.dart';
import '../widgets/intro_body.dart';

class IntroTabletView extends StatelessWidget {
  const IntroTabletView({
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
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: IntroBody(
                  data: data,
                  controller: controller,
                  onCompleteOnboarding: onCompleteOnboarding,
                  onNext: onNext,
                  onPrevious: onPrevious,
                  onIndexChanged: onIndexChanged,
                  height: 250.r,
                  firstHeightBox: 24,
                  secondHeightBox: 56,
                  thirdHeightBox: 24,
                  fourthHeightBox: 32,
                ),
              ),
            ),
          ),
        ),
      );
}
