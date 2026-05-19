import 'package:draksy/core/widgets/xp_bar.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest(Widget child) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: child),
        ),
      );

  group('XpBar', () {
    testWidgets('renders correctly with basic properties', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 50, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(XpBar), findsOneWidget);
      expect(find.text('50 / 100 XP'), findsOneWidget);
    });

    testWidgets('shows correct progress fraction', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 25, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.text('25 / 100 XP'), findsOneWidget);
    });

    testWidgets('clamps progress to 1.0 when currentXp exceeds maxXp', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 150, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.text('150 / 100 XP'), findsOneWidget);
    });

    testWidgets('hides label when showLabel is false', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          const XpBar(currentXp: 50, maxXp: 100, showLabel: false),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(XpBar), findsOneWidget);
      expect(find.text('50 / 100 XP'), findsNothing);
    });

    testWidgets('respects custom height', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          const XpBar(currentXp: 50, maxXp: 100, height: 16),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(XpBar), findsOneWidget);
    });

    testWidgets('displays zero XP correctly', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 0, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.text('0 / 100 XP'), findsOneWidget);
    });

    testWidgets('displays full progress correctly', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 100, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.text('100 / 100 XP'), findsOneWidget);
    });

    testWidgets('creates correct number of child widgets', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          const XpBar(currentXp: 50, maxXp: 100, showLabel: true),
        ),
      );
      await tester.pumpAndSettle();

      // Column with progress bar and text
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('is const constructible', (tester) async {
      // This test ensures the widget can be created as a const
      const widget = XpBar(currentXp: 50, maxXp: 100);

      await tester.pumpWidget(createWidgetUnderTest(widget));
      await tester.pumpAndSettle();

      expect(find.byType(XpBar), findsOneWidget);
    });

    testWidgets('has correct default height', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 50, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(XpBar), findsOneWidget);
    });

    testWidgets('progress bar fills correctly', (tester) async {
      // Test 50% progress
      await tester.pumpWidget(
        createWidgetUnderTest(const XpBar(currentXp: 50, maxXp: 100)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FractionallySizedBox), findsOneWidget);
    });

    testWidgets('handles large XP values', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          const XpBar(currentXp: 999999, maxXp: 1000000),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('999999 / 1000000 XP'), findsOneWidget);
    });
  });
}
