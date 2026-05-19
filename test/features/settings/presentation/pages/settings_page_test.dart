import 'package:draksy/core/theme/theme_provider.dart';
import 'package:draksy/features/settings/presentation/models/settings_view_data.dart';
import 'package:draksy/features/settings/presentation/pages/settings_page.dart';
import 'package:draksy/features/settings/presentation/providers/settings_provider.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeNotifier extends Mock implements ThemeNotifier {
  @override
  ThemeMode build() => ThemeMode.light;
}

void main() {
  late MockThemeNotifier mockThemeNotifier;

  setUp(() {
    mockThemeNotifier = MockThemeNotifier();
  });

  Widget createWidgetUnderTest({
    ThemeMode themeMode = ThemeMode.light,
    String email = 'test@example.com',
  }) {
    final settingsData = SettingsViewData(
      email: email,
      dailyGoalXp: 50,
      reminderTime: '8:00 PM',
      isSoundEnabled: true,
      voiceSpeed: 'Normal',
      themeMode: themeMode,
      isHapticsEnabled: true,
    );

    return ProviderScope(
      overrides: [
        settingsViewProvider.overrideWithValue(settingsData),
        themeProvider.overrideWith(() => mockThemeNotifier),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1000, 2000),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsPage(),
        ),
      ),
    );
  }

  group('SettingsPage', () {
    testWidgets('renders all settings sections', (tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });
  });
}
