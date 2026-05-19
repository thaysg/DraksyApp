/// Route name constants for the app
abstract class AppRoutes {
  AppRoutes._();

  /// Splash screen route
  static const String splash = 'splash';

  /// Intro (Onboarding) screen route
  static const String intro = 'intro';

  /// Welcome screen route
  static const String welcome = 'welcome';

  /// Login screen route
  static const String login = 'login';

  /// Home screen route
  static const String home = 'home';

  /// World map screen route
  static const String lessonPath = 'lesson-path';

  /// Lesson list screen route
  static const String lessons = 'lessons';

  /// Lesson detail (intro) screen route
  static const String lessonDetail = 'lesson-detail';

  /// Battle screen route
  static const String battle = 'battle';

  /// Profile screen route
  static const String profile = 'profile';
  static const String editProfile = 'edit-profile';
  static const String progressHistory = 'progress-history';

  /// Settings screen route
  static const String settings = 'settings';
}

/// Route path constants for the app
abstract class AppPaths {
  AppPaths._();

  /// Splash screen path
  static const String splash = '/';

  /// Intro screen path
  static const String intro = '/intro';

  /// Welcome screen path
  static const String welcome = '/welcome';

  /// Login screen path
  static const String login = '/login';

  /// Home screen path
  static const String home = '/home';

  /// World map screen path
  static const String lessonPath = '/lesson-path/:title';

  /// Lesson detail screen path
  static const String lessonDetail = '/lesson-detail/:unitId/:lessonId/:title';

  /// Lesson list screen path
  static const String lessons = '/lessons-list/:worldId';

  /// Battle screen path
  static const String battle = '/battle/:lessonId';

  /// Profile screen path
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String progressHistory = '/progress-history';

  /// Settings screen path
  static const String settings = '/settings';
}
