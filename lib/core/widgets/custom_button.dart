import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extension.dart';
import '../extensions/spacing.dart';
import '../theme/app_text_styles.dart';

enum ButtonType { elevated, outlined, text }

/// Custom elevated button widget for draksy with an RPG feel.
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    this.text,
    super.key,
    this.isLoading = false,
    this.type = ButtonType.elevated,
    this.width,
    this.height = 56,
    this.icon,
    this.assetIcon,
    this.iconTrailing = false,
    this.padding,
    this.borderRadius = 15,
    this.fontSize,
    this.textColor,
    this.outlineStyle,
    this.child,
  });
  final VoidCallback? onPressed;
  final String? text;
  final bool isLoading;
  final ButtonType type;
  final double? width;
  final double? height;
  final IconData? icon;
  final String? assetIcon;
  final bool iconTrailing;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? fontSize;
  final Color? textColor;
  final ButtonStyle? outlineStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    final buttonWidget = _buildButton(context, colorScheme);

    // If width or height is specified, wrap in SizedBox
    // If only height is specified, width defaults to full width
    if (width != null || height != null) {
      return SizedBox(
        width: width ?? (height != null ? double.infinity : null),
        height: height,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }

  Widget _buildButton(BuildContext context, ColorScheme colorScheme) {
    final style = outlineStyle ??
        (borderRadius != null
            ? (type == ButtonType.outlined
                ? OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius!),
                    ),
                  )
                : type == ButtonType.elevated
                    ? ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius!),
                        ),
                      )
                    : null)
            : null);

    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: _buildChild(context, textColor ?? colorScheme.onPrimary),
        );

      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: _buildChild(context, textColor ?? colorScheme.onSurface),
        );

      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: _buildChild(context, textColor ?? colorScheme.primary),
        );
    }
  }

  Widget _buildChild(BuildContext context, Color textColor) {
    if (isLoading) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (child != null) {
      return child!;
    }

    final textWidget = Text(
      text ?? '',
      style: AppTextStyles.titleMedium(context).copyWith(
        fontSize: fontSize ?? 12.sp,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );

    if (icon == null && assetIcon == null) {
      return textWidget;
    }

    final iconWidget = icon != null
        ? Icon(icon, size: 20, color: textColor)
        : Image.asset(assetIcon!, width: 20, height: 20, color: textColor);

    if (iconTrailing) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: textWidget),
          8.widthBox,
          iconWidget,
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          8.widthBox,
          Flexible(child: textWidget),
        ],
      );
    }
  }
}
