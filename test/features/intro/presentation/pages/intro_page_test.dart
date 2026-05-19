import 'package:draksy/core/providers/storage_providers.dart';
import 'package:draksy/features/intro/presentation/pages/intro_page.dart';
import 'package:draksy/features/intro/presentation/widgets/intro_page_view.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async => true);
  });

  Widget createWidgetUnderTest() => ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockPrefs),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: IntroPage(),
          ),
        ),
      );

  group('IntroPage', () {
    testWidgets('renders introduction screen with pages', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(IntroPageView), findsOneWidget);
      expect(find.text('Draksy'), findsOneWidget);
    });

    testWidgets('can navigate through pages', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Tap next button (Get Started on first page)
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      expect(
        find.text('Learn languages in a fun\nand gamified way'),
        findsOneWidget,
      );

      // Tap next icon
      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pumpAndSettle();

      expect(
        find.text('Track progress, streaks,\nand rewards'),
        findsOneWidget,
      );

      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Practice daily and\nimprove fast'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });
  });
}
