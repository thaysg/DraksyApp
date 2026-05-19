/// Centralized application constants.
/// All hardcoded values should be replaced by references to this class.
abstract class AppConstants {
  AppConstants._();

  // ===============================================
  // GAME CONSTANTS
  // ===============================================

  /// Initial lives for free users
  static const int initialLivesFree = 5;

  /// Maximum lives
  static const int maxLives = 5;

  /// Lives regeneration interval (hours)
  static const int livesRegenerationHours = 4;

  /// Base XP required for level 1 to 2
  static const int baseXpRequired = 100;

  /// Maximum player level
  static const int maxLevel = 100;

  /// Minimum level
  static const int minLevel = 1;

  // ===============================================
  // XP & PROGRESSION
  // ===============================================

  /// Exponent for XP formula
  static const double xpExponent = 1.5;

  /// Perfect lesson bonus XP percentage
  static const double perfectLessonBonusPercent = 0.2;

  /// Streak multiplier base (multiplied by streak days)
  static const double streakMultiplierBase = 0.01;

  // ===============================================
  // WORLDS & LESSONS
  // ===============================================

  /// Number of lessons per world (MVP)
  static const int lessonsPerWorld = 15;

  /// Number of worlds in MVP
  static const int mvpWorlds = 3;

  /// Total number of worlds planned
  static const int totalWorldsPlanned = 12;

  // ===============================================
  // EXERCISES
  // ===============================================

  /// Minimum exercises per lesson
  static const int minExercisesPerLesson = 5;

  /// Maximum exercises per lesson
  static const int maxExercisesPerLesson = 10;

  // ===============================================
  // SYNC
  // ===============================================

  /// Auto sync interval (minutes) for premium
  static const int autoSyncIntervalMinutes = 5;

  /// Max sync retries
  static const int maxSyncRetries = 3;

  /// Sync retry delay (milliseconds)
  static const int syncRetryDelayMs = 1000;

  /// Exponential backoff multiplier for sync retries
  static const double syncBackoffMultiplier = 1.5;

  // ===============================================
  // SRS (Spaced Repetition)
  // ===============================================

  /// Initial ease factor for SRS
  static const double srsInitialEaseFactor = 2.5;

  /// Minimum ease factor for SRS
  static const double srsMinEaseFactor = 1.3;

  /// Initial review interval (days)
  static const int srsInitialIntervalDays = 1;

  // ===============================================
  // MONETIZATION
  // ===============================================

  /// Premium subscription price (BRL)
  static const double premiumPricePerMonth = 14.90;

  /// Lives pack price (5 lives)
  static const double livesPackPrice = 4.90;

  /// Ad reward lives count
  static const int adRewardLives = 1;

  /// Max ad rewards per day
  static const int maxAdRewardsPerDay = 3;

  // ===============================================
  // DISPLAY
  // ===============================================

  /// App bar height
  static const double appBarHeight = 56;

  /// Bottom navigation height
  static const double bottomNavHeight = 64;

  /// Card border radius
  static const double cardBorderRadius = 16;

  /// Button border radius
  static const double buttonBorderRadius = 30;

  /// Dialog border radius
  static const double dialogBorderRadius = 20;

  // ===============================================
  // ANIMATION DURATIONS
  // ===============================================

  /// Short animation duration (ms)
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);

  /// Medium animation duration (ms)
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);

  /// Long animation duration (ms)
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // ===============================================
  // API TIMEOUTS
  // ===============================================

  /// Connection timeout (seconds)
  static const int connectionTimeoutSeconds = 10;

  /// Read timeout (seconds)
  static const int readTimeoutSeconds = 15;

  /// Write timeout (seconds)
  static const int writeTimeoutSeconds = 15;

  // ===============================================
  // STORAGE
  // ===============================================

  /// Storage key for user theme preference
  static const String storageKeyTheme = 'app_theme';

  /// Storage key for user locale preference
  static const String storageKeyLocale = 'app_locale';

  /// Storage key for user ID
  static const String storageKeyUserId = 'user_id';

  /// Storage key for auth token
  static const String storageKeyAuthToken = 'auth_token';

  // ===============================================
  // LANGUAGES
  // ===============================================

  /// Supported language codes
  static const List<String> supportedLanguageCodes = [
    'en', // English
    'pt', // Portuguese
    'es', // Spanish
  ];

  /// Default language code
  static const String defaultLanguageCode = 'en';

  /// Supported locales
  static const List<String> supportedLocales = ['en', 'pt'];
}
