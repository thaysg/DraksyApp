/// Constants for all Hive box names used in the app.
///
/// Never use raw strings to open boxes — always reference [AppBoxNames].
abstract class AppBoxNames {
  AppBoxNames._();

  /// Stores cached user profile data.
  static const String user = 'user_box';

  /// Stores lesson progress per unit/node.
  static const String lessonProgress = 'lesson_progress_box';

  /// Stores pre-generated lesson nodes.
  static const String lessonNodes = 'lesson_nodes_box';

  /// Stores daily challenge state.
  static const String dailyChallenge = 'daily_challenge_box';

  /// Stores app settings not covered by SharedPreferences
  /// (e.g. language preference).
  static const String settings = 'settings_box';
}
