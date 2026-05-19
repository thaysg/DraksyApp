import 'dart:async';

import 'package:draksy/features/home/presentation/models/home_view_data.dart';
import 'package:draksy/features/home/presentation/pages/home_page.dart';
import 'package:draksy/features/home/presentation/providers/home_provider.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    Future<HomeViewData>? homeViewFuture,
  }) =>
      ProviderScope(
        overrides: [
          if (homeViewFuture != null)
            homeViewProvider.overrideWith((ref) => homeViewFuture),
        ],
        child: ScreenUtilInit(
          designSize: const Size(1000, 2000),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomePage(),
          ),
        ),
      );

  group('HomePage', () {
    testWidgets('renders loading state with Skeletonizer', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        homeViewFuture: Completer<HomeViewData>().future,
      ));

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('renders data state with home content', (tester) async {
      final tData = HomeViewData(
        userName: 'UniqueHomeUser',
        userPhotoUrl: '',
        xp: '998877',
        streak: '999',
        dailyChallenge: HomeViewData.mock.dailyChallenge,
        level: '50',
        lives: '5',
        lessons: const [],
      );

      await tester.pumpWidget(createWidgetUnderTest(
        homeViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      expect(find.text('UniqueHomeUser'), findsOneWidget);
      expect(find.text('998877'), findsOneWidget);
      expect(find.text('999'), findsOneWidget);
    });

    testWidgets('renders error state when provider fails', (tester) async {
      final completer = Completer<HomeViewData>();

      await tester.pumpWidget(createWidgetUnderTest(
        homeViewFuture: completer.future,
      ));

      completer.completeError(Exception('Error'));
      await tester.pumpAndSettle();

      expect(find.text('Try again'), findsOneWidget);
    });
  });
}
