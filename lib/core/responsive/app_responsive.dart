import 'package:flutter/material.dart';

/// Responsive design breakpoints and utilities for draksy.
/// Provides helpers for mobile and tablet layouts, portrait/landscape orientation.
class AppResponsive {
  AppResponsive._();

  // ===============================================
  // BREAKPOINTS
  // ===============================================

  /// Mobile breakpoint (px)
  static const double mobileBreakpoint = 600;

  /// Tablet breakpoint (px)
  static const double tabletBreakpoint = 900;

  // ===============================================
  // DEVICE TYPE HELPERS
  // ===============================================

  /// Is mobile device (width < 600)
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  /// Is tablet device (600 <= width < 900)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Is desktop device (width >= 900)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  // ===============================================
  // ORIENTATION HELPERS
  // ===============================================

  /// Is portrait orientation
  static bool isPortrait(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.portrait;

  /// Is landscape orientation
  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  // ===============================================
  // LAYOUT HELPERS
  // ===============================================

  /// Returns horizontal padding based on device size
  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) {
      return 64;
    }
    if (isTablet(context)) {
      return 32;
    }
    return 20;
  }

  /// Returns grid column count based on device size and orientation
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) {
      return 4;
    }
    if (isTablet(context)) {
      return 3;
    }
    if (isLandscape(context)) {
      return 2;
    }
    return 1;
  }

  /// Returns maximum content width for centered layouts
  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 800;
    }
    if (isTablet(context)) {
      return 600;
    }
    return double.infinity;
  }

  /// Returns screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  /// Returns screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  /// Returns safe area padding
  static EdgeInsets safePadding(BuildContext context) =>
      MediaQuery.paddingOf(context);

  /// Returns view insets (keyboard height, etc.)
  static EdgeInsets viewInsets(BuildContext context) =>
      MediaQuery.viewInsetsOf(context);

  /// Returns aspect ratio of screen
  static double aspectRatio(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width / size.height;
  }

  /// Is small screen (mobile in portrait)
  static bool isSmallScreen(BuildContext context) =>
      isMobile(context) && isPortrait(context);

  /// Is medium screen (tablet or mobile landscape)
  static bool isMediumScreen(BuildContext context) =>
      isTablet(context) || (isMobile(context) && isLandscape(context));

  /// Is large screen (desktop)
  static bool isLargeScreen(BuildContext context) => isDesktop(context);
}
