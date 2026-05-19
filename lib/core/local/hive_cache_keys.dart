import '../constants/app_box_names.dart';

/// Centralized Hive cache box names and keys.
///
/// Key format is `boxName__innerKey`.
class HiveCacheKeys {
  HiveCacheKeys._();

  static const String separator = '__';

  // Box names mapping to AppBoxNames for consistency
  static const String userBox = AppBoxNames.user;
  static const String lessonProgressBox = AppBoxNames.lessonProgress;
  static const String lessonNodesBox = AppBoxNames.lessonNodes;
  static const String dailyChallengeBox = AppBoxNames.dailyChallenge;
  static const String settingsBox = AppBoxNames.settings;

  // Composite key helpers
  static String lessonNodesKey(String lessonId) =>
      '$lessonNodesBox$separator$lessonId';

  static String lessonProgressKey(String unitId, String nodeId) =>
      '$lessonProgressBox$separator${unitId}_$nodeId';

  static const Set<String> userScopedBoxes = {
    userBox,
    lessonProgressBox,
    lessonNodesBox,
    dailyChallengeBox,
  };
}
