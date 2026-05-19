import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Material Design 3 theme configuration for draksy.
/// Includes both light and dark themes using Crimson Red palette.
class AppTheme {
  AppTheme._();

  // ===============================================
  // TEMA LIGHT
  // ===============================================

  /// Light theme based on Crimson Red palette
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryAppColor,
          primaryContainer: AppColors.primaryLight,
          secondary: AppColors.secondaryLight,
          tertiary: AppColors.tertiaryLight,
          surface: AppColors.surfaceLight,
          error: AppColors.error,
          onPrimary: AppColors.surfaceLight,
          onSecondary: AppColors.surfaceLight,
          onTertiary: AppColors.surfaceLight,
          onSurface: AppColors.textPrimaryLight,
        ),
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) =>
              const Icon(Icons.chevron_left, size: 30),
        ),
        scaffoldBackgroundColor: AppColors.scafoldBackgroungLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryAppColor,
          foregroundColor: AppColors.surfaceLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.appBarTitle(context),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceLight,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          //  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryAppColor,
            foregroundColor: AppColors.surfaceLight,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: AppTextStyles.buttonLarge(context),
            minimumSize: const Size(45, 50),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryAppColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: AppTextStyles.buttonMedium(context),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryAppColor,
            side: const BorderSide(color: AppColors.primaryAppColor, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: AppTextStyles.buttonMedium(context),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: AppColors.primaryAppColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: AppTextStyles.inputHint(context).copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge(context),
          displayMedium: AppTextStyles.displayMedium(context),
          displaySmall: AppTextStyles.displaySmall(context),
          headlineMedium: AppTextStyles.headlineMedium(context),
          bodyLarge: AppTextStyles.bodyLarge(context),
          bodyMedium: AppTextStyles.bodyMedium(context),
          bodySmall: AppTextStyles.bodySmall(context),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.primaryAppColor,
          contentTextStyle: AppTextStyles.snackBarContent(context),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        dialogTheme: DialogThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.surfaceLight,
          titleTextStyle: AppTextStyles.dialogTitle(context).copyWith(
            color: AppColors.textPrimaryLight,
          ),
        ),
      );

  // ===============================================
  // TEMA DARK
  // ===============================================

  /// Dark theme based on Crimson Red palette
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDark,
          primaryContainer: AppColors.primaryDeep,
          secondary: AppColors.secondaryDark,
          tertiary: AppColors.tertiaryDark,
          surface: AppColors.surfaceDark,
          error: AppColors.error,
          onPrimary: AppColors.textPrimaryDark,
          onSecondary: AppColors.textPrimaryDark,
          onTertiary: AppColors.textPrimaryDark,
          onSurface: AppColors.textPrimaryDark,
        ),
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) =>
              const Icon(Icons.chevron_left, size: 30),
        ),
        scaffoldBackgroundColor: AppColors.scafoldBackgroungDark,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryDeep,
          foregroundColor: AppColors.surfaceLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.appBarTitle(context)
              .copyWith(color: AppColors.surfaceLight),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceDark,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          //margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryAppColor,
            foregroundColor: AppColors.surfaceLight,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: AppTextStyles.buttonLarge(context),
            minimumSize: const Size(45, 50),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: AppTextStyles.buttonMedium(context),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
            side: const BorderSide(color: AppColors.primaryDark, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: AppTextStyles.buttonMedium(context),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: AppColors.primaryDark, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: AppTextStyles.inputHint(context).copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.h1(context)
              .copyWith(color: AppColors.textPrimaryDark),
          displayMedium: AppTextStyles.h2(context)
              .copyWith(color: AppColors.textPrimaryDark),
          displaySmall: AppTextStyles.h3(context)
              .copyWith(color: AppColors.textPrimaryDark),
          headlineMedium: AppTextStyles.h4(context)
              .copyWith(color: AppColors.textPrimaryDark),
          bodyLarge: AppTextStyles.bodyLarge(context)
              .copyWith(color: AppColors.textPrimaryDark),
          bodyMedium: AppTextStyles.bodyMedium(context)
              .copyWith(color: AppColors.textPrimaryDark),
          bodySmall: AppTextStyles.bodySmall(context)
              .copyWith(color: AppColors.textSecondaryDark),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.primaryDeep,
          contentTextStyle: AppTextStyles.snackBarContent(context)
              .copyWith(color: AppColors.surfaceLight),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        dialogTheme: DialogThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.surfaceDark,
          titleTextStyle: AppTextStyles.dialogTitle(context).copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
      );
}
