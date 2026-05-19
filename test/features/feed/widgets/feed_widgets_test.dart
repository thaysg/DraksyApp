import 'package:draksy/features/feed/presentation/models/feed_view_data.dart';
import 'package:draksy/features/feed/widgets/activity_item_card.dart';
import 'package:draksy/features/feed/widgets/invite_friends_card.dart';
import 'package:draksy/features/feed/widgets/ranking_card.dart';
import 'package:draksy/features/feed/widgets/weekly_challenge_card.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest(Widget child,
          {Size designSize = const Size(1200, 1200)}) =>
      ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: child),
        ),
      );

  group('InviteFriendsCard', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const InviteFriendsCard(),
      ));

      expect(find.byIcon(Icons.group_add_rounded), findsOneWidget);
      expect(find.textContaining('Invite'), findsOneWidget);
    });
  });

  group('ActivityItemCard', () {
    testWidgets('renders activity info correctly', (tester) async {
      const size = Size(1200, 1200);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const data = FeedActivityData(
        id: '1',
        userName: 'Test User',
        userPhotoUrl: 'https://example.com/photo.jpg',
        type: FeedActivityType.lesson,
        description: 'Completed a lesson',
        timeAgo: '2h',
        likes: 10,
        value: '+50',
      );

      await tester.pumpWidget(createWidgetUnderTest(
        const ActivityItemCard(data: data),
        designSize: size,
      ));

      expect(find.text('Completed a lesson'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.textContaining('2h'), findsOneWidget);
    });
  });

  group('WeeklyChallengeCard', () {
    testWidgets('renders challenge progress correctly', (tester) async {
      const size = Size(1200, 1200);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const data = FeedWeeklyChallengeData(
        title: 'Weekly Challenge',
        description: 'Complete lessons',
        completedLessons: 10,
        totalLessons: 20,
        remainingTime: '2d',
      );

      await tester.pumpWidget(createWidgetUnderTest(
        const WeeklyChallengeCard(data: data),
        designSize: size,
      ));

      expect(find.text('Weekly Challenge'), findsOneWidget);
      expect(find.text('10/20'), findsOneWidget);
      expect(find.text('2d'), findsOneWidget);
    });
  });

  group('RankingCard', () {
    testWidgets('renders ranking info correctly', (tester) async {
      const size = Size(1200, 1200);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const data = FeedRankingData(
        userId: 'ranking-1',
        userName: 'Ranker',
        userPhotoUrl: 'https://example.com/photo.jpg',
        xp: '1500',
        position: 1,
      );

      await tester.pumpWidget(createWidgetUnderTest(
        const RankingCard(data: data, height: 300),
        designSize: size,
      ));

      expect(find.text('Ranker'), findsOneWidget);
      expect(find.textContaining('1500'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });
  });
}
