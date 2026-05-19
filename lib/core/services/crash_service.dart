import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crash_service.g.dart';

@riverpod
CrashService crashService(Ref ref) => CrashService();

/// Mock implementation of [CrashService] for the portfolio.
class CrashService {
  Future<void> setUserId(String userId) async {
    // Mock: Do nothing in portfolio
  }

  Future<void> recordError(dynamic error, StackTrace? stack,
      {bool fatal = false}) async {
    // Mock: Log to console in debug mode
  }

  Future<void> log(String message) async {
    // Mock: Do nothing in portfolio
  }
}
