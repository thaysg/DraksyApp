import 'package:draksy/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProviderContainer makeContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  // ─────────────────────────────────────────────
  // AuthTypeNotifier
  // ─────────────────────────────────────────────
  group('AuthTypeNotifier', () {
    test('initial state is AuthType.login', () {
      final container = makeContainer();
      expect(container.read(authTypeProvider), AuthType.login);
    });

    test('toggle() changes to AuthType.signup', () {
      final container = makeContainer();
      container.read(authTypeProvider.notifier).toggle();
      expect(container.read(authTypeProvider), AuthType.signup);
    });

    test('toggle() twice returns to AuthType.login', () {
      final container = makeContainer();
      container.read(authTypeProvider.notifier).toggle();
      container.read(authTypeProvider.notifier).toggle();
      expect(container.read(authTypeProvider), AuthType.login);
    });

    test('toggle() resets emailConfirmationSent to false', () {
      final container = makeContainer();

      // Mark as sent first
      container.read(emailConfirmationSentProvider.notifier).markSent();
      expect(container.read(emailConfirmationSentProvider), isTrue);

      // Toggle should reset it
      container.read(authTypeProvider.notifier).toggle();
      expect(container.read(emailConfirmationSentProvider), isFalse);
    });

    test('authType setter updates state', () {
      final container = makeContainer();
      container.read(authTypeProvider.notifier).authType = AuthType.signup;
      expect(container.read(authTypeProvider), AuthType.signup);
    });
  });

  // ─────────────────────────────────────────────
  // AuthLoading
  // ─────────────────────────────────────────────
  group('AuthLoading', () {
    test('initial state is false', () {
      final container = makeContainer();
      expect(container.read(authLoadingProvider), isFalse);
    });

    test('isLoading = true changes state to true', () {
      final container = makeContainer();
      container.read(authLoadingProvider.notifier).isLoading = true;
      expect(container.read(authLoadingProvider), isTrue);
    });

    test('isLoading = false returns to false', () {
      final container = makeContainer();
      container.read(authLoadingProvider.notifier).isLoading = true;
      container.read(authLoadingProvider.notifier).isLoading = false;
      expect(container.read(authLoadingProvider), isFalse);
    });

    test('isLoading getter returns current state', () {
      final container = makeContainer();
      container.read(authLoadingProvider.notifier).isLoading = true;
      expect(container.read(authLoadingProvider.notifier).isLoading, isTrue);
    });
  });

  // ─────────────────────────────────────────────
  // EmailConfirmationSent
  // ─────────────────────────────────────────────
  group('EmailConfirmationSent', () {
    test('initial state is false', () {
      final container = makeContainer();
      expect(container.read(emailConfirmationSentProvider), isFalse);
    });

    test('markSent() changes state to true', () {
      final container = makeContainer();
      container.read(emailConfirmationSentProvider.notifier).markSent();
      expect(container.read(emailConfirmationSentProvider), isTrue);
    });

    test('reset() returns state to false', () {
      final container = makeContainer();
      container.read(emailConfirmationSentProvider.notifier).markSent();
      container.read(emailConfirmationSentProvider.notifier).reset();
      expect(container.read(emailConfirmationSentProvider), isFalse);
    });
  });

  // ─────────────────────────────────────────────
  // PasswordVisibility
  // ─────────────────────────────────────────────
  group('PasswordVisibility', () {
    test('initial state is true (password obscured)', () {
      final container = makeContainer();
      expect(container.read(passwordVisibilityProvider), isTrue);
    });

    test('toggle() changes to false (password visible)', () {
      final container = makeContainer();
      container.read(passwordVisibilityProvider.notifier).toggle();
      expect(container.read(passwordVisibilityProvider), isFalse);
    });

    test('toggle() twice returns to true (password obscured again)', () {
      final container = makeContainer();
      container.read(passwordVisibilityProvider.notifier).toggle();
      container.read(passwordVisibilityProvider.notifier).toggle();
      expect(container.read(passwordVisibilityProvider), isTrue);
    });
  });
}
