import 'package:flutter/material.dart';

import '../responsive/app_responsive.dart';
import '../theme/app_colors.dart';

/// Extension on BuildContext to access responsive and app utilities.
/// Provides convenient access to responsive helpers throughout the app.
extension ContextExtension on BuildContext {
  // ===============================================
  // RESPONSIVE HELPERS
  // ===============================================

  /// Is mobile device
  bool get isMobile => AppResponsive.isMobile(this);

  /// Is tablet device
  bool get isTablet => AppResponsive.isTablet(this);

  /// Is desktop device
  bool get isDesktop => AppResponsive.isDesktop(this);

  /// Is portrait orientation
  bool get isPortrait => AppResponsive.isPortrait(this);

  /// Is landscape orientation
  bool get isLandscape => AppResponsive.isLandscape(this);

  /// Is small screen
  bool get isSmallScreen => AppResponsive.isSmallScreen(this);

  /// Is medium screen
  bool get isMediumScreen => AppResponsive.isMediumScreen(this);

  /// Is large screen
  bool get isLargeScreen => AppResponsive.isLargeScreen(this);

  /// Screen height
  double get screenHeight => AppResponsive.screenHeight(this);

  /// Screen width
  double get screenWidth => AppResponsive.screenWidth(this);

  /// Horizontal padding based on device size
  double get horizontalPadding => AppResponsive.horizontalPadding(this);

  /// Grid columns based on device size
  int get gridColumns => AppResponsive.gridColumns(this);

  /// Maximum content width for centered layouts
  double get maxContentWidth => AppResponsive.maxContentWidth(this);

  /// Safe area padding
  EdgeInsets get safePadding => AppResponsive.safePadding(this);

  /// View insets (keyboard height, etc.)
  EdgeInsets get viewInsets => AppResponsive.viewInsets(this);

  /// Screen aspect ratio
  double get aspectRatio => AppResponsive.aspectRatio(this);

  // ===============================================
  // THEME HELPERS
  // ===============================================

  /// Current theme data
  ThemeData get theme => Theme.of(this);

  /// Is dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;
  // MediaQuery.of(this).platformBrightness == Brightness.dark;

  /// Color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // ===============================================
  // MEDIA QUERY HELPERS
  // ===============================================

  /// Device padding
  EdgeInsets get devicePadding => MediaQuery.paddingOf(this);

  /// Device view insets
  EdgeInsets get deviceViewInsets => MediaQuery.viewInsetsOf(this);

  /// Device size
  Size get deviceSize => MediaQuery.sizeOf(this);

  /// Device text scaler
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  /// Is keyboard visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  // ===============================================
  // SNACKBAR HELPERS
  // ===============================================

  /// Show snackbar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: AppColors.error,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
}
