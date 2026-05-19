import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A custom text form field that follows the app's design language.
///
/// If [useAuthStyles] is true, it applies the specific styles used in the
/// authentication forms (white borders and text).
/// If false (default), it uses the theme-defined styles.
class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.useAuthStyles = false,
    this.validator,
    this.onChanged,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.decoration,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool useAuthStyles;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    // Authentication specific styles
    final authTextStyle = AppTextStyles.bodyMedium(context).copyWith(
      color: AppColors.backgroundLight,
    );

    final authBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColors.backgroundLight,
      ),
    );

    // Determine which style to use
    final effectiveStyle = useAuthStyles ? authTextStyle : style;
    final effectiveHintStyle = useAuthStyles ? authTextStyle : hintStyle;
    final effectiveLabelStyle = useAuthStyles ? authTextStyle : labelStyle;

    final effectiveBorder = useAuthStyles ? authBorder : border;
    final effectiveEnabledBorder = useAuthStyles ? authBorder : enabledBorder;
    final effectiveFocusedBorder = useAuthStyles ? authBorder : focusedBorder;

    // Determine cursor color
    final effectiveCursorColor =
        useAuthStyles ? AppColors.backgroundLight : null;

    // Apply color to icons if using auth styles
    Widget? effectivePrefixIcon;
    if (prefixIcon != null) {
      effectivePrefixIcon = useAuthStyles && prefixIcon is Icon
          ? Icon(
              (prefixIcon! as Icon).icon,
              color: AppColors.backgroundLight,
              size: (prefixIcon! as Icon).size,
            )
          : prefixIcon;
    }

    Widget? effectiveSuffixIcon;
    if (suffixIcon != null) {
      effectiveSuffixIcon = useAuthStyles && suffixIcon is Icon
          ? Icon(
              (suffixIcon! as Icon).icon,
              color: AppColors.backgroundLight,
              size: (suffixIcon! as Icon).size,
            )
          : suffixIcon;
    }

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: effectiveStyle,
      cursorColor: effectiveCursorColor,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: effectivePrefixIcon,
            suffixIcon: effectiveSuffixIcon,
            hintStyle: effectiveHintStyle,
            labelStyle: effectiveLabelStyle,
            border: effectiveBorder,
            enabledBorder: effectiveEnabledBorder,
            focusedBorder: effectiveFocusedBorder,
            errorBorder: errorBorder,
          ),
    );
  }
}
