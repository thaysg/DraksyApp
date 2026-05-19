import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

/// Centralized color palette for draksy.
/// All app colors are defined here following Material Design 3 principles.
/// Never use Color(0xFF...) inline - always reference colors from this class.
class AppColors {
  AppColors._();

  // ===============================================
  // CORES PRIMÁRIAS — Crimson Red
  // ===============================================
  /// Soft Red for light theme
  static const Color primaryLight = Color(0xFFEF5350);

  /// Rose clear for dark theme
  static const Color primaryDark = Color(0xFFEF9A9A);

  /// Crimson Red (base)
  static const Color primaryAppColor = Color(0xFFF52D5B);

  /// Dark Red (press state)
  static const Color primaryDeep = Color(0xFFB71C1C);

  // ===============================================
  // CORES SECUNDÁRIAS — Amber Gold
  // ===============================================
  /// Amber Gold
  static const Color secondaryLight = Color(0xFFFF8F00);

  /// Gold brighter in dark
  static const Color secondaryDark = Color(0xFFFFCC02);

  // ===============================================
  // CORES TERCIÁRIAS — Deep Teal
  // ===============================================
  /// Deep Teal
  static const Color tertiaryLight = Color(0xFF00695C);

  /// Teal lighter in dark
  static const Color tertiaryDark = Color(0xFF4DB6AC);

  // ===============================================
  // ACENTO — Warm Coral
  // ===============================================
  /// Deep Orange / Warm Coral
  static const Color accent = Color(0xFFFF5722);

  // ===============================================
  // CORES DE FUNDO
  // ===============================================
  /// Branco levemente quente
  static const Color backgroundLight = Color(0xFFFFFBFB);

  /// Dark background
  static const Color backgroundDark = Color(0xFF242A32);

  /// Superfície com toque rosado
  static const Color surfaceLight = Color(0xFFF9F0F0);

  /// Dark surface
  static const Color surfaceDark = Color(0xFF2A2D3E);

  static const Color scafoldBackgroungLight = Color(0xFFF7F2FB);
  static const Color scafoldBackgroungDark = Color(0xFF0F0F12);

  // ===============================================
  // CORES DE TEXTO
  // ===============================================
  /// Primary text light
  static Color textPrimaryLight =
      const Color(0xFF2A2D3E).withValues(alpha: 0.87);

  /// Primary text dark

  /// Primary text dark
  static const Color textPrimaryDark = Color(0xFFFFFFFF);

  /// Secondary text light
  static const Color textSecondaryLight = Color(0xFF6B7280);

  /// Secondary text dark
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // ===============================================
  // CORES FUNCIONAIS (fixas)
  // ===============================================
  /// Success color
  static const Color success = Color(0xFF00695C);

  /// Error color
  static const Color error = Color(0xFFD32F2F);

  /// Warning color
  static const Color warning = Color(0xFFFF8F00);

  /// Info color
  static const Color info = Color(0xFF1976D2);

  static const Color successLight = Color(0xFF90CAF9);

  static const Color purple = Color(0xFF9575CD);
  // ===============================================
  // CORES DO JOGO (fixas, não mudam com tema)
  // ===============================================
  /// Pure white

  /// Brown used for RPG elements and text readability
  static const Color rpgBrown = Color(0xFF5D4037);

  /// Orange used for RPG elements and gradients
  static const Color rpgOrange = Color(0xFFE49834);

  /// Gold color (fixed)
  static const Color gold = Color(0xFFFFD700);

  /// Silver color (fixed)
  static const Color silver = Color(0xFFC0C0C0);

  /// Bronze color (fixed)
  static const Color bronze = Color(0xFFCD7F32);

  /// HP color (red)
  static const Color hp = Color(0xFFD32F2F);

  /// Mana color
  static const Color mana = Color(0xFF1976D2);

  /// Transparent color
  static const Color transparent = Color(0x00000000);

  static const Color green = Color(0xFF7CB342);

  // ===============================================
  // GRADIENTES
  // ===============================================
  /// Primary gradient (Crimson Red)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryAppColor, primaryDeep],
  );

  /// Hero gradient
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEF5350), Color(0xFFB71C1C)],
  );

  /// XP bar gradient
  static LinearGradient xpBarGradient = const LinearGradient(
    colors: [
      //   primaryAppColor,
      secondaryLight,
      secondaryDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// World card gradient
  static LinearGradient worldCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFFEF5350).withValues(alpha: 0.5),
      const Color(0xFFFF8F00).withValues(alpha: 0.5)
    ],
  );

  static const LinearGradient homeUserGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF52D5B),
      Color.fromARGB(255, 238, 119, 117),
      Color.fromARGB(248, 228, 152, 52)
    ],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF242A32), Color(0xFF3A2936)],
  );

  static const LinearGradient livesGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF52D5B), Color(0xFFEE7775)],
  );

  /// Premium background blue
  static const Color premiumNavy = Color(0xFF1A1F3A);

  /// Premium background purple
  static const Color premiumPurple = Color(0xFF2D1B4E);

  /// Premium gradient for Draksy Plus
  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [premiumNavy, premiumPurple],
  );

  // ===============================================
  // ==========================
  // COLOR SCHEME (Material 3)
  // ==========================

  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color onPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color onSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color surfaceContainerHighest(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  static Color background(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color errorColor(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color outline(BuildContext context) =>
      Theme.of(context).colorScheme.outline;

  static Color primaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  static Color onPrimaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryContainer;

  // ==========================
  // THEMEDATA DIRECT COLORS
  // ==========================

  static Color primaryColor(BuildContext context) =>
      Theme.of(context).primaryColor;

  static Color scaffoldBackground(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color divider(BuildContext context) => Theme.of(context).dividerColor;

  static Color hint(BuildContext context) => Theme.of(context).hintColor;

  static Color disabled(BuildContext context) =>
      Theme.of(context).disabledColor;

  static Color focus(BuildContext context) => Theme.of(context).focusColor;

  static Color hover(BuildContext context) => Theme.of(context).hoverColor;

  static Color shadow(BuildContext context) => Theme.of(context).shadowColor;

  static Color canvas(BuildContext context) => Theme.of(context).canvasColor;

  static Color card(BuildContext context) => Theme.of(context).cardColor;

  static Color xpBarBackground(BuildContext context) =>
      context.isDarkMode ? Colors.grey[800]! : Colors.grey[400]!;

  static Color textPrimary(BuildContext context) =>
      context.isDarkMode ? textPrimaryDark : textPrimaryLight;

  static Color textSecondary(BuildContext context) =>
      context.isDarkMode ? textSecondaryDark : textSecondaryLight;
}
