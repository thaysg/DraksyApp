import 'package:draksy/core/utils/pagination/paginated_state.dart';
import 'package:draksy/features/feed/presentation/models/feed_view_data.dart';
import 'package:draksy/features/feed/presentation/pages/feed_page.dart';
import 'package:draksy/features/feed/presentation/providers/feed_activities_provider.dart';
import 'package:draksy/features/feed/presentation/providers/feed_provider.dart';
import 'package:draksy/features/feed/views/feed_mobile_view.dart';
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
  Widget createWidgetUnderTest({
    Size designSize = const Size(400, 1000),
  }) =>
      ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => ProviderScope(
          overrides: [
            feedViewProvider.overrideWith(
              (ref) => Future.value(FeedViewData.mock),
            ),
            feedActivitiesProvider.overrideWith(
              () => MockFeedActivitiesNotifier(
                PaginatedState<FeedActivityData>.initial().copyWith(
                  isLoading: false,
                  items: FeedViewData.mockActivities,
                ),
              ),
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: FeedPage(),
          ),
        ),
      );

  group('FeedPage', () {
    testWidgets('renders mobile view', (tester) async {
      const size = Size(400, 1000);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest(designSize: size));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(FeedPage), findsOneWidget);
      expect(find.byType(FeedMobileView), findsOneWidget);
    });
  });
}
