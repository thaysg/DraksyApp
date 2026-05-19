import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive/app_responsive.dart';
import 'app_colors.dart';

/// Centralized text styles using Google Fonts (Nunito & nunito) with
/// integrated colors.
/// All text styling should reference styles from this class.
class AppTextStyles {
  AppTextStyles._();

  /// Font family
  static String get fontFamily => GoogleFonts.nunito().fontFamily!;
  static String get fantasyFontFamily => GoogleFonts.nunito().fontFamily!;

  /// Responsive font size helper.
  /// Returns the base size on desktop to avoid excessive scaling,
  /// and uses ScreenUtil (.sp) on mobile and tablet.
  static double _fs(BuildContext context, double size) =>
      AppResponsive.isDesktop(context) ? size : size.sp;

  // ===============================================
  // HEADINGS (RPG Style)
  // ===============================================

  /// H1 - 32px, weight 800
  static TextStyle h1(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 32.sp),
        fontWeight: FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.5,
        color: AppColors.onSurface(context),
      );

  /// H2 - 28px, weight 800
  static TextStyle h2(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 28),
        fontWeight: FontWeight.w800,
        height: 1.3,
        letterSpacing: -0.3,
        color: AppColors.onSurface(context),
      );

  /// H3 - 24px, weight 700
  static TextStyle h3(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 24),
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: AppColors.onSurface(context),
      );

  /// H4 - 20px, weight 700
  static TextStyle h4(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 18),
        fontWeight: FontWeight.w700,
        height: 1.4,
        color: AppColors.onSurface(context),
      );

  // ===============================================
  // BODY
  // ===============================================

  /// Body Large - 16px, weight 400
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 16),
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: AppColors.onSurface(context),
      );

  /// Body Medium - 14px, weight 600
  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 14),
        fontWeight: FontWeight.w600,
        height: 1.6,
        color: AppColors.onSurface(context),
      );

  /// Body Small - 12px, weight 400
  static TextStyle bodySmall(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 12),
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.onSurface(context),
      );

  // ===============================================
  // BUTTONS
  // ===============================================

  /// Button Large - 16px, weight 700
  static TextStyle buttonLarge(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 12),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: AppColors.onPrimary(context),
      );

  /// Button Medium - 14px, weight 700
  static TextStyle buttonMedium(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 14),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: AppColors.onPrimary(context),
      );

  // ===============================================
  // APP-SPECIFIC STYLES
  // ===============================================

  /// App bar title - 20px, weight 800
  static TextStyle appBarTitle(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 20),
        fontWeight: FontWeight.w800,
        letterSpacing: 0.2,
        color: AppColors.onPrimary(context),
      );

  /// XP bar label - 12px, weight 600
  static TextStyle xpBarLabel(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 12),
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimaryContainer(context),
      );

  /// World title - 18px, weight 800
  static TextStyle worldTitle(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 18),
        fontWeight: FontWeight.w800,
        color: AppColors.onSurface(context),
      );

  /// Level badge - 14px, weight 700
  static TextStyle levelBadge(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 14),
        fontWeight: FontWeight.w700,
        color: AppColors.onPrimary(context),
      );

  /// Monster name - 16px, weight 700
  static TextStyle monsterName(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 16),
        fontWeight: FontWeight.w700,
        color: AppColors.onSurface(context),
      );

  /// Question text - 18px, weight 600
  static TextStyle questionText(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 18),
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: AppColors.onSurface(context),
      );

  /// Option text - 16px, weight 500
  static TextStyle optionText(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 16),
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface(context),
      );

  /// Dialog title - 20px, weight 800
  static TextStyle dialogTitle(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 20),
        fontWeight: FontWeight.w800,
        color: AppColors.onSurface(context),
      );

  /// Score display - 36px, weight 900
  static TextStyle scoreDisplay(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 36),
        fontWeight: FontWeight.w900,
        letterSpacing: -1,
        color: AppColors.primary(context),
      );

  /// Snack bar content - 14px, weight 600
  static TextStyle snackBarContent(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 14),
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary(context),
      );

  /// Input hint - 14px, weight 400
  static TextStyle inputHint(BuildContext context) => GoogleFonts.nunito(
        fontSize: _fs(context, 14),
        fontWeight: FontWeight.w400,
        color: AppColors.onSurface(context).withValues(alpha: 0.6),
      );

  /// Display styles
  static TextStyle displayLarge(BuildContext context) => h1(context);
  static TextStyle displayMedium(BuildContext context) => h2(context);
  static TextStyle displaySmall(BuildContext context) => h3(context);
  static TextStyle headlineMedium(BuildContext context) => h4(context);

  static TextStyle font24Bold(BuildContext context) =>
      h1(context).copyWith(fontSize: _fs(context, 24));
  static TextStyle font32Bold(BuildContext context) =>
      h1(context).copyWith(fontSize: _fs(context, 32));
  static TextStyle font13PrimarySemiBold(BuildContext context) =>
      bodySmall(context).copyWith(
        fontSize: _fs(context, 13),
        fontWeight: FontWeight.w600,
        color: AppColors.primary(context),
      );
  static TextStyle font14SecondarySemiBold(BuildContext context) =>
      bodyMedium(context).copyWith(
        fontSize: _fs(context, 14),
        fontWeight: FontWeight.w600,
        color: AppColors.secondary(context),
      );
  static TextStyle font13Medium(BuildContext context) =>
      bodySmall(context).copyWith(
        fontSize: _fs(context, 13),
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface(context).withValues(alpha: 0.6),
      );
  static TextStyle font24BlackBold(BuildContext context) => font24Bold(context);
  static TextStyle font32BlueBold(BuildContext context) => font32Bold(context);
  static TextStyle font13BlueSemiBold(BuildContext context) =>
      font13PrimarySemiBold(context);
  static TextStyle font14DarkBlueSemiBold(BuildContext context) =>
      font14SecondarySemiBold(context);
  static TextStyle font13GrayMedium(BuildContext context) =>
      font13Medium(context);

  static TextStyle textTitle(BuildContext context) =>
      h4(context).copyWith(fontSize: _fs(context, 16));
  static TextStyle textSubTitle(BuildContext context) =>
      bodySmall(context).copyWith(fontWeight: FontWeight.w900);

  static TextStyle titleLarge(BuildContext context) => h3(context);
  static TextStyle titleMedium(BuildContext context) =>
      h4(context).copyWith(fontSize: _fs(context, 15));

  static TextStyle titleSmall(BuildContext context) => bodyMedium(context);

  static TextStyle headlineLarge(BuildContext context) => h1(context);
  static TextStyle headlineSmall(BuildContext context) => h4(context);

  static TextStyle labelLarge(BuildContext context) =>
      bodyMedium(context).copyWith(letterSpacing: 0.45);
  static TextStyle labelMedium(BuildContext context) => bodySmall(context)
      .copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.5);
  static TextStyle labelSmall(BuildContext context) =>
      bodySmall(context).copyWith(
          fontSize: _fs(context, 11),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5);

  static TextStyle textGoogleElevenBold500(BuildContext context) =>
      bodySmall(context)
          .copyWith(fontSize: _fs(context, 11), fontWeight: FontWeight.w500);
  static TextStyle smallHeadline(BuildContext context) =>
      h4(context).copyWith(fontSize: _fs(context, 24));

  static TextStyle error(BuildContext context) => bodyMedium(context).copyWith(
        color: AppColors.errorColor(context),
      );

  static TextStyle success(BuildContext context) =>
      bodyMedium(context).copyWith(
        color: AppColors.success,
      );

  static TextStyle warning(BuildContext context) =>
      bodyMedium(context).copyWith(
        color: AppColors.warning,
      );

  static TextStyle primaryText(BuildContext context) =>
      bodyMedium(context).copyWith(
        color: AppColors.primary(context),
      );

  static TextStyle secondaryText(BuildContext context) =>
      bodySmall(context).copyWith(
        color: AppColors.secondary(context),
      );
}

extension TextStyleColorExtension on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}
