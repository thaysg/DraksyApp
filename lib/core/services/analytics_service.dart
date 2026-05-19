import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_service.g.dart';

@riverpod
AnalyticsService analyticsService(Ref ref) => AnalyticsService();

/// Mock implementation of [AnalyticsService] for the portfolio.
class AnalyticsService {
  Future<void> setUserId(String? userId) async {
    // Mock: Do nothing or log to console in debug mode
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    // Mock: Do nothing or log to console in debug mode
  }

  Future<void> logLessonCompleted({
    required String lessonId,
    required String unitId,
    required int xpEarned,
  }) async {
    // Mock: Do nothing or log to console in debug mode
  }
}
