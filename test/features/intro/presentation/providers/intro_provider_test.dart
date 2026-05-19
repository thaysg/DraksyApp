import 'package:draksy/features/intro/presentation/providers/intro_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('IntroIndex', () {
    test('index starts at 0', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(introIndexProvider), 0);
    });

    test('set index updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(introIndexProvider.notifier).index = 2;

      expect(container.read(introIndexProvider), 2);
    });
  });
}
