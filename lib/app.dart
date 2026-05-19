import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/responsive/app_responsive.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'l10n/app_localizations.dart';

/// Root consumer widget for draksy app.
/// Sets up theming, localization, and navigation.
class AppWidget extends ConsumerWidget {
  /// Creates the app root widget
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) {
        final displayWidth = instance.screenWidth;
        if (displayWidth >= AppResponsive.tabletBreakpoint) {
          // On desktop, we avoid excessive scaling from the 360px design size.
          // Returning the base fontSize (1.0x) ensures standard desktop
          // text sizes.
          return fontSize.toDouble();
        }
        return fontSize.toDouble() * instance.scaleText;
      },
      builder: (context, child) => MaterialApp.router(
        // App info
        title: 'draksy',
        debugShowCheckedModeBanner: false,

        // Navigation
        routerConfig: router,

        // Theming
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: themeMode,

        // Device Preview
        locale: kDebugMode ? DevicePreview.locale(context) : null,
        builder: (context, child) {
          if (kDebugMode) {
            DevicePreview.appBuilder(context, child);
            // Re-apply our theme to ensure DevicePreview doesn't override it
            return Theme(
              data: themeMode == ThemeMode.dark
                  ? AppTheme.darkTheme(context)
                  : AppTheme.lightTheme(context),
              child: child ?? const SizedBox.shrink(),
            );
          }
          return child ?? const SizedBox.shrink();
        },

        // Localization
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
