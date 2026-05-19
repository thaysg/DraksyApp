import 'package:draksy/features/auth/domain/entities/user.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInWithEmail useCase;
  late MockAuthRepository mockRepository;

  final tUser = User(
    id: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    createdAt: DateTime(2024),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInWithEmail(mockRepository);
  });

  group('SignInWithEmail', () {
    test('returns success when repository returns success', () async {
      when(() => mockRepository.signInWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => StrautilsResponse.success(tUser));

      final result = await useCase('test@example.com', 'password123');

      expect(result.success, isTrue);
      expect(result.data, tUser);
    });

    test('returns error when repository returns error', () async {
      when(() => mockRepository.signInWithEmailAndPassword(any(), any()))
          .thenAnswer(
        (_) async => StrautilsResponse.error('Invalid credentials'),
      );

      final result = await useCase('test@example.com', 'wrongpassword');

      expect(result.error, isTrue);
      expect(result.message, 'Invalid credentials');
    });

    test('passes email and password correctly to repository', () async {
      when(() => mockRepository.signInWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => StrautilsResponse.success(tUser));

      await useCase('test@example.com', 'mypassword');

      verify(
        () => mockRepository.signInWithEmailAndPassword(
          'test@example.com',
          'mypassword',
        ),
      ).called(1);
    });
  });
}
