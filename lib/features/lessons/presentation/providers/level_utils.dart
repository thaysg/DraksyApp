import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/providers/localization_provider.dart';
import '../../../../core/theme/app_colors.dart';

class LevelUtils {
  LevelUtils._();

  static String getLocalizedTitle(WidgetRef ref, String levelName) {
    final l10n = ref.read(l10nProvider);
    switch (levelName) {
      case 'basic':
        return l10n.beginner;
      case 'medium':
        return l10n.intermediate;
      case 'advanced':
        return l10n.advanced;
      default:
        return levelName.capitalize();
    }
  }

  static String getLocalizedTitleFromRef(Ref ref, String levelName) {
    final l10n = ref.read(l10nProvider);
    switch (levelName) {
      case 'basic':
        return l10n.beginner;
      case 'medium':
        return l10n.intermediate;
      case 'advanced':
        return l10n.advanced;
      default:
        return levelName.capitalize();
    }
  }

  static String getLocalizedDescription(Ref ref, String levelName) {
    final l10n = ref.read(l10nProvider);
    switch (levelName) {
      case 'basic':
        return l10n.beginnerDesc;
      case 'medium':
        return l10n.intermediateDesc;
      case 'advanced':
        return l10n.advancedDesc;
      default:
        return '';
    }
  }

  static IconData getIconForLevel(String levelName) {
    switch (levelName) {
      case 'basic':
        return Icons.energy_savings_leaf_rounded;
      case 'medium':
        return Icons.local_fire_department_rounded;
      case 'advanced':
        return Icons.lock_rounded;
      default:
        return Icons.school;
    }
  }

  static Color getColorForLevel(String levelName) {
    switch (levelName) {
      case 'basic':
        return AppColors.green;
      case 'medium':
        return AppColors.purple;
      case 'advanced':
        return AppColors.textSecondaryLight;
      default:
        return AppColors.primaryAppColor;
    }
  }

  static String mapLevelToDifficulty(String levelName) {
    switch (levelName) {
      case 'basic':
        return 'beginner';
      case 'medium':
        return 'intermediate';
      case 'advanced':
        return 'advanced';
      default:
        return 'beginner';
    }
  }
}
