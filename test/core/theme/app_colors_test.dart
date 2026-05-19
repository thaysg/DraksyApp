import 'package:draksy/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    group('Gradient colors', () {
      test('xpBarGradient has correct colors', () {
        expect(
          AppColors.xpBarGradient.colors,
          equals([AppColors.secondaryLight, AppColors.secondaryDark]),
        );
      });

      test('xpBarGradient has correct alignment', () {
        expect(AppColors.xpBarGradient.begin, equals(Alignment.topLeft));
        expect(AppColors.xpBarGradient.end, equals(Alignment.bottomRight));
      });

      test('primaryGradient has correct colors', () {
        expect(
          AppColors.primaryGradient.colors,
          equals([AppColors.primaryAppColor, AppColors.primaryDeep]),
        );
      });

      test('heroGradient has correct colors', () {
        expect(
          AppColors.heroGradient.colors,
          equals([const Color(0xFFEF5350), const Color(0xFFB71C1C)]),
        );
      });

      test('worldCardGradient has correct colors', () {
        expect(
          AppColors.worldCardGradient.colors,
          equals([
            const Color(0xFFEF5350).withValues(alpha: 0.5),
            const Color(0xFFFF8F00).withValues(alpha: 0.5)
          ]),
        );
      });
    });

    group('Primary colors', () {
      test('primaryLight is correct', () {
        expect(AppColors.primaryLight, equals(const Color(0xFFEF5350)));
      });

      test('primaryAppColor is correct', () {
        expect(AppColors.primaryAppColor, equals(const Color(0xFFF52D5B)));
      });

      test('primaryDeep is correct', () {
        expect(AppColors.primaryDeep, equals(const Color(0xFFB71C1C)));
      });

      test('primaryDark is correct', () {
        expect(AppColors.primaryDark, equals(const Color(0xFFEF9A9A)));
      });
    });

    group('Functional colors', () {
      test('success is correct', () {
        expect(AppColors.success, equals(const Color(0xFF00695C)));
      });

      test('error is correct', () {
        expect(AppColors.error, equals(const Color(0xFFD32F2F)));
      });

      test('warning is correct', () {
        expect(AppColors.warning, equals(const Color(0xFFFF8F00)));
      });

      test('info is correct', () {
        expect(AppColors.info, equals(const Color(0xFF1976D2)));
      });
    });

    group('Game-specific colors', () {
      test('gold is correct', () {
        expect(AppColors.gold, equals(const Color(0xFFFFD700)));
      });

      test('silver is correct', () {
        expect(AppColors.silver, equals(const Color(0xFFC0C0C0)));
      });

      test('bronze is correct', () {
        expect(AppColors.bronze, equals(const Color(0xFFCD7F32)));
      });

      test('hp is correct', () {
        expect(AppColors.hp, equals(const Color(0xFFD32F2F)));
      });

      test('mana is correct', () {
        expect(AppColors.mana, equals(const Color(0xFF1976D2)));
      });
    });

    group('Background colors', () {
      test('backgroundLight is correct', () {
        expect(AppColors.backgroundLight, equals(const Color(0xFFFFFBFB)));
      });

      test('backgroundDark is correct', () {
        expect(AppColors.backgroundDark, equals(const Color(0xFF242A32)));
      });

      test('surfaceLight is correct', () {
        expect(AppColors.surfaceLight, equals(const Color(0xFFF9F0F0)));
      });

      test('surfaceDark is correct', () {
        expect(AppColors.surfaceDark, equals(const Color(0xFF2A2D3E)));
      });
    });

    group('Text colors', () {
      test('textPrimaryLight is correct', () {
        expect(AppColors.textPrimaryLight,
            equals(const Color(0xFF2A2D3E).withValues(alpha: 0.87)));
      });

      test('textPrimaryDark is correct', () {
        expect(AppColors.textPrimaryDark, equals(const Color(0xFFFFFFFF)));
      });

      test('textSecondaryLight is correct', () {
        expect(AppColors.textSecondaryLight, equals(const Color(0xFF6B7280)));
      });

      test('textSecondaryDark is correct', () {
        expect(AppColors.textSecondaryDark, equals(const Color(0xFFB0B0B0)));
      });
    });

    group('Secondary colors', () {
      test('secondaryLight is correct', () {
        expect(AppColors.secondaryLight, equals(const Color(0xFFFF8F00)));
      });

      test('secondaryDark is correct', () {
        expect(AppColors.secondaryDark, equals(const Color(0xFFFFCC02)));
      });
    });

    group('Tertiary colors', () {
      test('tertiaryLight is correct', () {
        expect(AppColors.tertiaryLight, equals(const Color(0xFF00695C)));
      });

      test('tertiaryDark is correct', () {
        expect(AppColors.tertiaryDark, equals(const Color(0xFF4DB6AC)));
      });
    });

    group('Accent color', () {
      test('accent is correct', () {
        expect(AppColors.accent, equals(const Color(0xFFFF5722)));
      });
    });
  });
}
