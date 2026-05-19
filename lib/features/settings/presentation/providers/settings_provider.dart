import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../models/settings_view_data.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  void build() {}
}

@riverpod
SettingsViewData settingsView(Ref ref) {
  final userAsync = ref.watch(authProvider);
  final themeMode = ref.watch(themeProvider);

  return SettingsViewData(
    email: userAsync.value?.email ?? '',
    dailyGoalXp: 50,
    reminderTime: '8:00 PM',
    isSoundEnabled: true,
    voiceSpeed: 'Normal',
    themeMode: themeMode,
    isHapticsEnabled: true,
  );
}
