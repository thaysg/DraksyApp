import 'package:draksy/core/providers/storage_providers.dart';
import 'package:draksy/features/splash/presentation/pages/splash_page.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.getBool(any())).thenReturn(null);
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashPage(),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(mockPrefs),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
  }

  group('SplashPage', () {
    testWidgets('renders logo and app name', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Allow fade-in animations to complete (800ms + delay)
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Draksy'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Clean up to avoid pending timers from FadeInWidget
      await tester.pumpAndSettle();
    });

    testWidgets('renders initial state', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(SplashPage), findsOneWidget);

      // Clean up to avoid pending timers
      await tester.pumpAndSettle();
    });
  });
}
