import 'package:draksy/features/auth/domain/entities/user.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/presentation/providers/auth_providers.dart';
import 'package:draksy/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('homeViewProvider', () {
    test('provides HomeViewData based on user info', () async {
      final tUser = User(
        id: '123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: DateTime(2024),
      );

      when(() => mockAuthRepository.userChanges)
          .thenAnswer((_) => Stream.value(tUser));
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => tUser);

      final container = makeContainer();

      // Ensure the provider has a listener so it doesn't auto-dispose
      // immediately
      final subscription = container.listen(homeViewProvider, (_, __) {});

      final result = await container.read(homeViewProvider.future);

      expect(result.userName, 'Test User');
      expect(result.xp, '2,450');

      subscription.close();
    });

    test('uses Learner as default name when user has no display name',
        () async {
      final tUser = User(
        id: '123',
        email: 'test@example.com',
        createdAt: DateTime(2024),
      );

      when(() => mockAuthRepository.userChanges)
          .thenAnswer((_) => Stream.value(tUser));
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => tUser);

      final container = makeContainer();
      final subscription = container.listen(homeViewProvider, (_, __) {});

      final result = await container.read(homeViewProvider.future);

      expect(result.userName, 'Learner');

      subscription.close();
    });
  });
}
