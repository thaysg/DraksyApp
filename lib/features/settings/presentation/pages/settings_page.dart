import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/theme_provider.dart';
import '../providers/settings_provider.dart';
import '../views/settings_desktop_view.dart';
import '../views/settings_mobile_view.dart';
import '../views/settings_tablet_view.dart';
import '../widgets/settings_title.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(settingsViewProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SettingsTitle(),
            ResponsiveLayoutBuilder(
              builder: (context, deviceType) {
                switch (deviceType) {
                  case DeviceType.mobile:
                    return SettingsMobileView(
                      data: data,
                      onToggleTheme: (_) =>
                          ref.read(themeProvider.notifier).toggleTheme(),
                    );
                  case DeviceType.tablet:
                    return SettingsTabletView(
                      data: data,
                      onToggleTheme: (_) =>
                          ref.read(themeProvider.notifier).toggleTheme(),
                    );
                  case DeviceType.desktop:
                    return SettingsDesktopView(
                      data: data,
                      onToggleTheme: (_) =>
                          ref.read(themeProvider.notifier).toggleTheme(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
