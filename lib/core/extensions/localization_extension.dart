import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Extension on BuildContext to access localization strings.
/// Provides convenient access to translated strings throughout the app.
///
/// Usage: `context.l10n.welcomeMessage`
extension LocalizationExtension on BuildContext {
  /// Returns the localization instance, never null
  AppLocalizations get l10n => AppLocalizations.of(this);
}
