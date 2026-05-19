import 'package:draksy/features/auth/domain/entities/user.dart';
import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignUpWithEmail useCase;
  late MockAuthRepository mockRepository;

  final tUser = User(
    id: '456',
    email: 'newuser@example.com',
    displayName: 'New User',
    createdAt: DateTime(2024),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignUpWithEmail(mockRepository);
  });

  group('SignUpWithEmail', () {
    test('returns success when repository returns success', () async {
      when(() => mockRepository.signUpWithEmailAndPassword(any(), any(), any()))
          .thenAnswer((_) async => StrautilsResponse.success(tUser));

      final result =
          await useCase('newuser@example.com', 'password123', 'New User');

      expect(result.success, isTrue);
      expect(result.data, tUser);
    });

    test('returns error when repository returns error', () async {
      when(() => mockRepository.signUpWithEmailAndPassword(any(), any(), any()))
          .thenAnswer(
        (_) async => StrautilsResponse.error('Email already in use'),
      );

      final result =
          await useCase('existing@example.com', 'password123', 'User');

      expect(result.error, isTrue);
      expect(result.message, 'Email already in use');
    });

    test('passes email, password and displayName correctly to repository',
        () async {
      when(() => mockRepository.signUpWithEmailAndPassword(any(), any(), any()))
          .thenAnswer((_) async => StrautilsResponse.success(tUser));

      await useCase('newuser@example.com', 'securepass', 'New User');

      verify(
        () => mockRepository.signUpWithEmailAndPassword(
          'newuser@example.com',
          'securepass',
          'New User',
        ),
      ).called(1);
    });
  });
}
