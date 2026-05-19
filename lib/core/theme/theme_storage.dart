import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  const ThemeStorage(this._prefs);
  final SharedPreferences _prefs;

  static const _key = 'theme_mode';

  ThemeMode loadThemeMode() {
    final themeName = _prefs.getString(_key);
    if (themeName == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setString(_key, mode.name);
  }
}
