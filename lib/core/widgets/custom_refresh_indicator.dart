import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    required this.onRefresh,
    required this.child,
    super.key,
  });
  final Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async => onRefresh(),
        color: AppColors.primary(context),
        strokeWidth: 3,
        edgeOffset: 20,
        displacement: 40,
        child: child,
      );
}
