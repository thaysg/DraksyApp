import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../l10n/app_localizations.dart';

part 'localization_provider.g.dart';

@riverpod
AppLocalizations l10n(Ref ref) {
  // This is a simple implementation that defaults to the platform locale.
  // In a real app, you might watch a locale provider that the user can change.
  final locale = WidgetsBinding.instance.platformDispatcher.locale;
  return lookupAppLocalizations(locale);
}
