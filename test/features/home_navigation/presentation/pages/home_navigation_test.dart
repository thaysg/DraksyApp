import 'package:draksy/core/utils/pagination/paginated_state.dart';
import 'package:draksy/features/feed/presentation/models/feed_view_data.dart';
import 'package:draksy/features/feed/presentation/providers/feed_activities_provider.dart';
import 'package:draksy/features/feed/presentation/providers/feed_provider.dart';
import 'package:draksy/features/home/presentation/models/home_view_data.dart';
import 'package:draksy/features/home/presentation/providers/home_provider.dart';
import 'package:draksy/features/home_navigation/page/home_navigation.dart';
import 'package:draksy/features/lessons/presentation/models/lessons_view_data.dart';
import 'package:draksy/features/lessons/presentation/providers/lessons_provider.dart';
import 'package:draksy/features/profile/presentation/models/profile_view_data.dart';
import 'package:draksy/features/profile/presentation/providers/profile_provider.dart';
import 'package:draksy/features/settings/presentation/models/settings_view_data.dart';
import 'package:draksy/features/settings/presentation/providers/settings_provider.dart';
import 'package:draksy/features/shop/presentation/models/shop_view_data.dart';
import 'package:draksy/features/shop/presentation/providers/shop_provider.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFeedActivitiesNotifier extends FeedActivitiesNotifier {
  MockFeedActivitiesNotifier(this._state);
  final PaginatedState<FeedActivityData> _state;

  @override
  PaginatedState<FeedActivityData> build() => _state;

  @override
  Future<void> loadInitial() async {}
}

void main() {
  const tSettingsData = SettingsViewData(
    email: 'test@example.com',
    dailyGoalXp: 50,
    reminderTime: '8:00 PM',
    isSoundEnabled: true,
    voiceSpeed: 'Normal',
    themeMode: ThemeMode.light,
    isHapticsEnabled: true,
  );

  final tHomeData = HomeViewData(
    userName: 'HomeUser',
    userPhotoUrl: '',
    xp: '9876',
    streak: '42',
    dailyChallenge: HomeViewData.mock.dailyChallenge,
    level: '10',
    lives: '5',
    lessons: const [],
  );

  const tShopData = ShopViewData(
    lives: '5',
    gems: '5432',
    plans: [],
    powerUps: [],
  );

  const tLessonsData = LessonsViewData(
    lives: '5',
    gems: '1234',
    categories: [],
  );

  const tProfileData = ProfileViewData(
    userName: 'UniqueUser',
    userTag: '@unique',
    email: 'unique@example.com',
    photo: '',
    level: 1,
    totalXp: '0',
    streak: 0,
    lessons: 0,
    accuracy: '0%',
    currentXp: 0,
    maxXp: 100,
    badges: [],
    languages: [],
    bio: 'Devoted language learner.',
  );

  const tFeedData = FeedViewData.mock;

  Widget createWidgetUnderTest() => ProviderScope(
        overrides: [
          homeViewProvider.overrideWith((ref) => Future.value(tHomeData)),
          shopViewProvider.overrideWith((ref) => Future.value(tShopData)),
          lessonsViewProvider.overrideWith((ref) => Future.value(tLessonsData)),
          profileViewProvider.overrideWith((ref) => Future.value(tProfileData)),
          feedViewProvider.overrideWith((ref) => Future.value(tFeedData)),
          feedActivitiesProvider.overrideWith(
            () => MockFeedActivitiesNotifier(
              PaginatedState<FeedActivityData>.initial().copyWith(
                isLoading: false,
                items: FeedViewData.mockActivities,
              ),
            ),
          ),
          settingsViewProvider.overrideWithValue(tSettingsData),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomeNavigation(),
          ),
        ),
      );

  group('HomeNavigation', () {
    testWidgets('renders first page (Home) by default', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('9876'), findsWidgets);
    });

    testWidgets('can navigate to Feed via bottom bar', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('FEED'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Desafio Semanal'), findsOneWidget);
    });

    testWidgets('can navigate to Shop via bottom bar', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('SHOP'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('5432'), findsWidgets);
    });

    testWidgets('can navigate to Lessons via floating button', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Find FloatingActionButton in FloatingButtonWidget
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('1234'), findsWidgets);
    });

    testWidgets('can navigate to Profile via bottom bar', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('PROFILE'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('UniqueUser'), findsOneWidget);
    });
  });
}
