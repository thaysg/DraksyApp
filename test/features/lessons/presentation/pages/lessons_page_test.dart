import 'dart:async';

import 'package:draksy/features/lessons/presentation/models/lessons_view_data.dart';
import 'package:draksy/features/lessons/presentation/pages/lessons_page.dart';
import 'package:draksy/features/lessons/presentation/providers/lessons_provider.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    Future<LessonsViewData>? lessonsViewFuture,
  }) =>
      ProviderScope(
        overrides: [
          if (lessonsViewFuture != null)
            lessonsViewProvider.overrideWith((ref) => lessonsViewFuture),
        ],
        child: ScreenUtilInit(
          designSize: const Size(1080, 2400),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: LessonsPage(),
          ),
        ),
      );

  group('LessonsPage', () {
    testWidgets('renders loading state with Skeletonizer', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        lessonsViewFuture: Completer<LessonsViewData>().future,
      ));

      expect(find.byType(LessonsPage), findsOneWidget);
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('renders data state with categories', (tester) async {
      const tData = LessonsViewData(
        lives: '5',
        gems: '887766',
        categories: [
          LessonCategoryData(
            level: 1,
            title: 'Unique Category',
            description: 'Category Subtitle',
            progress: 0.5,
            timeInMinutes: 10,
            icon: Icons.school,
            iconColor: Colors.blue,
          ),
        ],
      );

      await tester.pumpWidget(createWidgetUnderTest(
        lessonsViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Unique Category'), findsWidgets);
      expect(find.text('887766'), findsOneWidget);
    });

    testWidgets('renders error state when provider fails', (tester) async {
      final completer = Completer<LessonsViewData>();

      await tester.pumpWidget(createWidgetUnderTest(
        lessonsViewFuture: completer.future,
      ));

      completer.completeError(Exception('Error'));
      await tester.pumpAndSettle();

      expect(find.text('Try again'), findsOneWidget);
    });
  });
}
