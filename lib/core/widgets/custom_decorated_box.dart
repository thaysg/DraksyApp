import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';
import '../theme/app_colors.dart';

class CustomDecoratedBox extends StatelessWidget {
  const CustomDecoratedBox(
      {required this.child,
      this.color,
      this.borderColor,
      this.gradient,
      this.shape = BoxShape.rectangle,
      this.boxShadow,
      this.borderRadius,
      this.padding,
      this.opacity,
      super.key});
  final Color? color;
  final Widget child;
  final Color? borderColor;
  final Gradient? gradient;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? opacity;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: gradient != null
              ? null
              : (color ??
                      (context.isDarkMode
                          ? AppColors.backgroundDark
                          : AppColors.backgroundLight))
                  .withValues(alpha: opacity ?? 0.6),
          shape: shape,
          gradient: gradient,
          boxShadow: boxShadow,
          borderRadius: shape == BoxShape.rectangle
              ? (borderRadius ?? BorderRadius.circular(20))
              : null,
          border: Border.all(
            color: borderColor ?? AppColors.primaryDark.withValues(alpha: 0.1),
            width: 2,
          ),
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: child,
        ),
      );
}
