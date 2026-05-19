import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/theme/app_colors.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.purple,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            width: 60.r,
            height: 60.r,
            child: FloatingActionButton(
              onPressed: onTap,
              backgroundColor: AppColors.primaryAppColor,
              elevation: 4,
              shape: const CircleBorder(),
              child: Image.asset(
                AppIcons.bottomBar,
                width: 80,
                height: 80,
              ),
            ),
          ),
        ),
      );
}
