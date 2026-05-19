import 'package:draksy/features/auth/domain/entities/user.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInWithGoogle useCase;
  late MockAuthRepository mockRepository;

  final tUser = User(
    id: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    createdAt: DateTime(2024),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInWithGoogle(mockRepository);
  });

  group('SignInWithGoogle', () {
    test('returns success when repository returns success', () async {
      when(() => mockRepository.signInWithGoogle())
          .thenAnswer((_) async => StrautilsResponse.success(tUser));

      final result = await useCase();

      expect(result.success, isTrue);
      expect(result.data, tUser);
    });

    test('returns error when repository returns error', () async {
      when(() => mockRepository.signInWithGoogle()).thenAnswer(
        (_) async => StrautilsResponse.error('Google sign in failed'),
      );

      final result = await useCase();

      expect(result.error, isTrue);
      expect(result.message, 'Google sign in failed');
    });

    test('delegates call to repository', () async {
      when(() => mockRepository.signInWithGoogle())
          .thenAnswer((_) async => StrautilsResponse.success(tUser));

      await useCase();

      verify(() => mockRepository.signInWithGoogle()).called(1);
    });
  });
}
