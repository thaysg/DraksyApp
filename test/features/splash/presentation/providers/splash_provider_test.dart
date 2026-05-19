import 'package:draksy/core/providers/storage_providers.dart';
import 'package:draksy/features/auth/domain/entities/user.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/presentation/providers/auth_providers.dart';
import 'package:draksy/features/splash/presentation/providers/splash_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockSharedPreferences mockPrefs;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    mockAuthRepository = MockAuthRepository();
  });

  ProviderContainer makeContainer(
      MockSharedPreferences prefs, MockAuthRepository authRepo) {
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        authRepositoryProvider.overrideWithValue(authRepo),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('SplashNotifier', () {
    test('initial state is loading', () {
      final container = makeContainer(mockPrefs, mockAuthRepository);
      final subscription = container.listen(splashProvider, (_, __) {});

      expect(subscription.read(), const AsyncValue<SplashState>.loading());
    });

    test('emits navigateToIntro when onboarding is not completed', () async {
      when(() => mockPrefs.getBool(kOnboardingCompletedKey)).thenReturn(null);

      final container = makeContainer(mockPrefs, mockAuthRepository);

      // We need to keep the provider alive so ref.mounted is true
      final subscription = container.listen(splashProvider, (prev, next) {});

      // Wait for the artificial delay (3 seconds)
      final result = await container.read(splashProvider.future);

      expect(result, SplashState.navigateToIntro);
      verify(() => mockPrefs.getBool(kOnboardingCompletedKey)).called(1);

      subscription.close();
    });

    test('emits navigateToIntro when onboarding is completed but user is null',
        () async {
      when(() => mockPrefs.getBool(kOnboardingCompletedKey)).thenReturn(true);
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => null);

      final container = makeContainer(mockPrefs, mockAuthRepository);

      // We need to keep the provider alive so ref.mounted is true
      final subscription = container.listen(splashProvider, (prev, next) {});

      // Wait for the artificial delay (3 seconds)
      final result = await container.read(splashProvider.future);

      // Current logic in splash_provider returns navigateToIntro
      // if user is null
      expect(result, SplashState.navigateToIntro);
      verify(() => mockPrefs.getBool(kOnboardingCompletedKey)).called(1);
      verify(() => mockAuthRepository.getCurrentUser()).called(1);

      subscription.close();
    });

    test('emits navigateToHome when onboarding is completed and user exists',
        () async {
      final tUser = User(
        id: '123',
        email: 'test@example.com',
        createdAt: DateTime(2024),
      );

      when(() => mockPrefs.getBool(kOnboardingCompletedKey)).thenReturn(true);
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => tUser);

      final container = makeContainer(mockPrefs, mockAuthRepository);

      final subscription = container.listen(splashProvider, (prev, next) {});

      final result = await container.read(splashProvider.future);

      expect(result, SplashState.navigateToHome);
      verify(() => mockPrefs.getBool(kOnboardingCompletedKey)).called(1);
      verify(() => mockAuthRepository.getCurrentUser()).called(1);

      subscription.close();
    });
  });
}
