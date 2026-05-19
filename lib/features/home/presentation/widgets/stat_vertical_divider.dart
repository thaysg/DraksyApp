import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class StatVerticalDivider extends StatelessWidget {
  const StatVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.textSecondaryLight.withValues(alpha: 0.3),
        ),
        child: const SizedBox(
          width: 1,
          height: 40,
        ),
      );
}
