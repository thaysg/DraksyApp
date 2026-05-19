import 'dart:async';

import 'package:draksy/features/shop/presentation/models/shop_view_data.dart';
import 'package:draksy/features/shop/presentation/pages/shop_page.dart';
import 'package:draksy/features/shop/presentation/providers/shop_provider.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    Future<ShopViewData>? shopViewFuture,
  }) =>
      ProviderScope(
        overrides: [
          if (shopViewFuture != null)
            shopViewProvider.overrideWith((ref) => shopViewFuture),
        ],
        child: ScreenUtilInit(
          designSize: const Size(1080, 2400),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ShopPage(),
          ),
        ),
      );

  group('ShopPage', () {
    testWidgets('renders loading state with Skeletonizer', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        shopViewFuture: Completer<ShopViewData>().future,
      ));

      expect(find.byType(ShopPage), findsOneWidget);
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('renders data state with shop content', (tester) async {
      const tData = ShopViewData(
        lives: '5',
        gems: '999',
        plans: [
          ShopPlanData(
            title: 'Unique Plan',
            price: r'$9.99',
            period: '/ month',
            benefits: ['Benefit'],
            buttonText: 'Buy',
          ),
        ],
        powerUps: [
          ShopPowerUpData(
            title: 'Unique PowerUp',
            description: 'Description',
            icon: Icons.bolt,
            iconColor: Colors.blue,
            price: '50',
            buttonText: 'Get',
          ),
        ],
      );

      await tester.pumpWidget(createWidgetUnderTest(
        shopViewFuture: Future.value(tData),
      ));
      await tester.pumpAndSettle();

      expect(find.text('999'), findsOneWidget);
      expect(find.text('Unique Plan'), findsOneWidget);
      expect(find.text('Unique PowerUp'), findsOneWidget);
    });

    testWidgets('renders error state when provider fails', (tester) async {
      final completer = Completer<ShopViewData>();

      await tester.pumpWidget(createWidgetUnderTest(
        shopViewFuture: completer.future,
      ));

      completer.completeError(Exception('Error'));
      await tester.pumpAndSettle();

      expect(find.text('Try again'), findsOneWidget);
    });
  });
}
