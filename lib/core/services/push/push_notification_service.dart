import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_service.g.dart';

@riverpod
PushNotificationService pushNotificationService(Ref ref) =>
    PushNotificationService();

/// Mock implementation of [PushNotificationService] for the portfolio.
class PushNotificationService {
  Future<void> initialize() async {
    // Mock: Do nothing in portfolio
  }

  Future<String?> getToken() async => 'mock_fcm_token';

  Stream<String> get onTokenRefresh => const Stream.empty();
}
