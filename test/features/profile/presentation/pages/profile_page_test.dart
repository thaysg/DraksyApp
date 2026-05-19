import 'dart:async';

import 'package:draksy/core/local/local_data_base.dart';
import 'package:draksy/core/providers/storage_providers.dart';
import 'package:draksy/core/services/analytics_service.dart';
import 'package:draksy/core/services/crash_service.dart';
import 'package:draksy/core/services/push/fcm_token_remote_data_source.dart';
import 'package:draksy/core/services/push/push_notification_service.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/presentation/providers/auth_providers.dart';
import 'package:draksy/features/profile/presentation/models/profile_view_data.dart';
import 'package:draksy/features/profile/presentation/pages/profile_page.dart';
import 'package:draksy/features/profile/presentation/providers/profile_provider.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockCrashService extends Mock implements CrashService {}

class MockPushNotificationService extends Mock
    implements PushNotificationService {}

class MockFcmTokenRemoteDataSource extends Mock
    implements FcmTokenRemoteDataSource {}

class MockLocalDataBase extends Mock implements LocalDataBase {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockAnalyticsService mockAnalyticsService;
  late MockCrashService mockCrashService;
  late MockPushNotificationService mockPushNotificationService;
  late MockFcmTokenRemoteDataSource mockFcmTokenRemoteDataSource;
  late MockLocalDataBase mockLocalDb;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAnalyticsService = MockAnalyticsService();
    mockCrashService = MockCrashService();
    mockPushNotificationService = MockPushNotificationService();
    mockFcmTokenRemoteDataSource = MockFcmTokenRemoteDataSource();
    mockLocalDb = MockLocalDataBase();

    when(() => mockAuthRepository.userChanges)
        .thenAnswer((_) => const Stream.empty());
    when(() => mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => null);
    when(() => mockPushNotificationService.getToken())
        .thenAnswer((_) async => null);

    when(() => mockAuthRepository.signOut())
        .thenAnswer((_) async => StrautilsResponse.success(null));
  });

  Widget createWidgetUnderTest({
    Future<ProfileViewData>? profileViewFuture,
  }) =>
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          analyticsServiceProvider.overrideWithValue(mockAnalyticsService),
          crashServiceProvider.overrideWithValue(mockCrashService),
          pushNotificationServiceProvider
              .overrideWithValue(mockPushNotificationService),
          fcmTokenRemoteDataSourceProvider
              .overrideWithValue(mockFcmTokenRemoteDataSource),
          localDataBaseProvider.overrideWithValue(mockLocalDb),
          if (profileViewFuture != null)
            profileViewProvider.overrideWith((ref) => profileViewFuture),
        ],
        child: ScreenUtilInit(
          designSize: const Size(1000, 2000),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ProfilePage(),
          ),
        ),
      );

  group('ProfilePage', () {
    testWidgets('renders loading state with Skeletonizer', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest(
        profileViewFuture: Completer<ProfileViewData>().future,
      ));

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('renders data state with profile info', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final tData = ProfileViewData.mock;

      await tester.pumpWidget(createWidgetUnderTest(
        profileViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      expect(find.text(tData.userName), findsOneWidget);
      expect(find.textContaining(tData.userTag), findsWidgets);
    });

    testWidgets('renders settings option', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final tData = ProfileViewData.mock;

      await tester.pumpWidget(createWidgetUnderTest(
        profileViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      final settingsButton = find.byIcon(Icons.settings_rounded);
      expect(settingsButton, findsOneWidget);
    });

    testWidgets('calls logout when logout action is triggered', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final tData = ProfileViewData.mock;

      await tester.pumpWidget(createWidgetUnderTest(
        profileViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      final logoutButton = find.text('Logout');
      await tester.ensureVisible(logoutButton);
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      verify(() => mockAuthRepository.signOut()).called(1);
    });

    testWidgets('shows delete account dialog when tapped', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final tData = ProfileViewData.mock;

      await tester.pumpWidget(createWidgetUnderTest(
        profileViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      final deleteAccountButton = find.text('Delete Account');
      await tester.ensureVisible(deleteAccountButton);
      await tester.tap(deleteAccountButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('Delete Account?'), findsOneWidget);
    });

    testWidgets('renders error state when provider fails', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final completer = Completer<ProfileViewData>();

      await tester.pumpWidget(createWidgetUnderTest(
        profileViewFuture: completer.future,
      ));

      completer.completeError(Exception('Error'));
      await tester.pumpAndSettle();

      expect(find.text('Try again'), findsOneWidget);
    });
  });
}
