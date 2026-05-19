// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Draksy';

  @override
  String get backToSignIn => 'Back to Sign In';

  @override
  String confirmationSentTo(String email) {
    return 'Confirmation sent to $email';
  }

  @override
  String get clickConfirmationLink =>
      'Click the confirmation link in the email to complete your registration';

  @override
  String get checkYourEmail => 'Check your email';

  @override
  String get feedTitle => 'Feed';

  @override
  String get feedSubtitle => 'See the community\'s performance';

  @override
  String get you => 'You';

  @override
  String get weeklyChallenge => 'Weekly Challenge';

  @override
  String get weeklyChallengeDesc =>
      'Complete 30 lessons this week and earn a reward!';

  @override
  String get weeklyRanking => 'Weekly Ranking';

  @override
  String activityCompletedLesson(String name) {
    return '$name completed a lesson';
  }

  @override
  String activityReachedLevel(String name) {
    return '$name reached a new level';
  }

  @override
  String activityMaintainedStreak(String name) {
    return '$name maintained the streak';
  }

  @override
  String activityWonAchievement(String name) {
    return '$name won an achievement';
  }

  @override
  String nowLevel(int level) {
    return 'Now at level $level!';
  }

  @override
  String daysStreak(int count) {
    return '$count day streak!';
  }

  @override
  String timeAgo(String time) {
    return '$time ago';
  }

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueButton => 'Continue';

  @override
  String get close => 'Close';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get settings => 'Settings';

  @override
  String get welcome => 'Welcome to Draksy';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get logout => 'Logout';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get worldMap => 'World Map';

  @override
  String get lessons => 'Lessons';

  @override
  String get battle => 'Battle';

  @override
  String get levels => 'Levels';

  @override
  String level(int number) {
    return 'Level $number';
  }

  @override
  String get xp => 'XP';

  @override
  String xpProgress(int current, int max) {
    return '$current / $max XP';
  }

  @override
  String get lives => 'Lives';

  @override
  String livesRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lives',
      one: '1 life',
      zero: 'No lives',
    );
    return '$_temp0';
  }

  @override
  String get streak => 'Streak';

  @override
  String streakDays(int count) {
    return '$count day streak';
  }

  @override
  String get coins => 'Coins';

  @override
  String world(int number) {
    return 'World $number';
  }

  @override
  String lesson(int number) {
    return 'Lesson $number';
  }

  @override
  String get locked => 'Locked';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get completed => 'Completed';

  @override
  String get boss => 'Boss';

  @override
  String get defeat => 'Defeat';

  @override
  String get exercise => 'Exercise';

  @override
  String get question => 'Question';

  @override
  String get answer => 'Answer';

  @override
  String get submit => 'Submit';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect';

  @override
  String get profile => 'Profile';

  @override
  String get stats => 'Statistics';

  @override
  String get totalXp => 'Total XP';

  @override
  String get achievements => 'Achievements';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Free';

  @override
  String get buyPremium => 'Upgrade to Premium';

  @override
  String get livesPackPrice => 'R\$ 4,90';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get noLivesTitle => 'Game Over';

  @override
  String get noLivesMessage => 'You\'ve lost all your lives. Try again later!';

  @override
  String get lessonCompletedTitle => 'Congratulations!';

  @override
  String get lessonFailedTitle => 'Not this time!';

  @override
  String get lessonCompletedMessage =>
      'You did great and unlocked the next lesson!';

  @override
  String get lessonFailedMessage =>
      'Review the lesson and try again to reach 80% accuracy.';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get tryAgain => 'Try again';

  @override
  String get introTitle1 => 'Draksy';

  @override
  String get introSubtitle1 => 'Master languages with your\nAI buddy';

  @override
  String get introTitle2 => 'Learn languages in a fun\nand gamified way';

  @override
  String get introSubtitle2 =>
      'Interactive exercises, daily quests,\nand your personal AI buddy make\nfluency feel like playing.';

  @override
  String get introTitle3 => 'Track progress, streaks,\nand rewards';

  @override
  String get introSubtitle3 =>
      'Build daily habits, unlock exclusive\nbadges, and watch your language\nskills level up every single day.';

  @override
  String get introTitle4 => 'Practice daily and\nimprove fast';

  @override
  String get introSubtitle4 =>
      'Commit to just 10 minutes a day.\nConsistent practice is the key to\nmastering any language.';

  @override
  String get introGetStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get logIn => 'Log in';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signInToContinue => 'Please sign in to continue';

  @override
  String get joinUsToStart => 'Join us to start your journey today';

  @override
  String get yourName => 'Your name';

  @override
  String get yourEmail => 'Your email';

  @override
  String get yourPassword => 'Your password';

  @override
  String get createPassword => 'Create a password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get orContinueWith => 'OR CONTINUE WITH';

  @override
  String get orSignUpWith => 'OR SIGN UP WITH';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String byCreatingAccount(String tos, String privacy) {
    return 'By creating an account, you agree to our $tos and $privacy.';
  }

  @override
  String get fullName => 'Full Name';

  @override
  String get signInWithApple => 'Sign in with Apple';

  @override
  String get skip => 'Skip';

  @override
  String get goodMorning => 'GOOD MORNING';

  @override
  String get goodAfternoon => 'GOOD AFTERNOON';

  @override
  String get goodEvening => 'GOOD EVENING';

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get continueLearning => 'Continue Learning';

  @override
  String get newGrammar => 'New Grammar';

  @override
  String get startChallenge => 'Start Challenge';

  @override
  String get resume => 'Resume';

  @override
  String get seeAll => 'See all';

  @override
  String get home => 'Home';

  @override
  String get shop => 'Shop';

  @override
  String unitLesson(int unit, int lesson) {
    return 'Unit $unit • Lesson $lesson';
  }

  @override
  String get livesFull => 'Full';

  @override
  String get masterPastTense => 'Master the\nPast Tense';

  @override
  String get progress => 'Progress';

  @override
  String lessonsCount(int count) {
    return '$count Lessons';
  }

  @override
  String get premiumMembership => 'Premium Membership';

  @override
  String get annualPlan => 'Annual Plan';

  @override
  String get monthlyPlan => 'Monthly Plan';

  @override
  String get bestValue => 'BEST VALUE';

  @override
  String get perYear => '/year';

  @override
  String get perMonth => '/month';

  @override
  String get unlimitedHearts => 'Unlimited Hearts';

  @override
  String get noAds => 'No Ads';

  @override
  String get offlineAccess => 'Offline Access';

  @override
  String get monthlyStreakRepair => 'Monthly Streak Repair';

  @override
  String get startFreeTrial => 'Start 14-Day Free Trial';

  @override
  String get subscribeMonthly => 'Subscribe Monthly';

  @override
  String get powerUps => 'Power-ups';

  @override
  String get refillHearts => 'Refill Hearts';

  @override
  String get getBackInTheGame => 'Get back in the game';

  @override
  String get streakFreeze => 'Streak Freeze';

  @override
  String get protectYourStreak => 'Protect your streak for 1 day';

  @override
  String get purchase => 'Purchase';

  @override
  String get buy => 'Buy';

  @override
  String refillHeartsAmount(int amount) {
    return '$amount Hearts';
  }

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get learningStats => 'Learning Stats';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get badges => 'Badges';

  @override
  String get manageBadges => 'Manage Badges';

  @override
  String get draksyPremium => 'Draksy Premium';

  @override
  String get manageSubscription => 'Manage subscription';

  @override
  String get inviteFriends => 'Invite Friends';

  @override
  String get inviteFriendsReward => 'Get 1 week free Premium!';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get faqContact => 'FAQ and contact';

  @override
  String get notifications => 'Notifications';

  @override
  String get mockUserName => 'Alex Dragonheart';

  @override
  String get mockUserTag => '@alex_learns';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get beginner => 'Beginner';

  @override
  String get champion => 'Champion';

  @override
  String get top10 => 'Top 10%';

  @override
  String get onFire => 'On Fire';

  @override
  String get thirtyDayStreak => '30 Day Streak';

  @override
  String get master => 'Master';

  @override
  String get account => 'Account';

  @override
  String get changePassword => 'Change your password';

  @override
  String get learningGoals => 'Learning & Goals';

  @override
  String get dailyGoal => 'Daily Goal';

  @override
  String xpPerDay(int xp) {
    return '$xp XP per day';
  }

  @override
  String get practiceReminders => 'Practice Reminders';

  @override
  String dailyAt(String time) {
    return 'Daily at $time';
  }

  @override
  String get difficulty => 'Difficulty';

  @override
  String get audio => 'Audio';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get voiceSpeed => 'Voice Speed';

  @override
  String get normal => 'Normal';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountTitle => 'Delete Account?';

  @override
  String get deleteAccountMessage =>
      'Are you sure you want to delete your account? This action cannot be undone and you will lose all your progress.';

  @override
  String get delete => 'Delete';

  @override
  String get general => 'General';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get sound => 'Sound';

  @override
  String get haptics => 'Haptics';

  @override
  String get termsPrivacy => 'Terms & Privacy';

  @override
  String get advanced => 'Advanced';

  @override
  String get allCategories => 'All Categories';

  @override
  String get grammar => 'Grammar';

  @override
  String get vocabulary => 'Vocabulary';

  @override
  String get beginnerDesc => 'Basics, greetings, and simple sentences.';

  @override
  String get intermediateDesc => 'Complex grammar and daily conversations.';

  @override
  String get advancedDesc => 'Fluent speaking and professional vocabulary.';

  @override
  String timePerLesson(int minutes) {
    return '~$minutes mins/lesson';
  }

  @override
  String get categoryProgress => 'Category Progress';

  @override
  String unitsCount(int current, int total) {
    return '$current/$total Lessons';
  }

  @override
  String unitNumber(int number) {
    return 'Lesson $number';
  }

  @override
  String nextUnit(int number) {
    return 'NEXT: LESSON $number';
  }

  @override
  String sectionCleared(int number) {
    return 'Section $number Cleared!';
  }

  @override
  String bonusXpEarned(int xp) {
    return 'You earned $xp bonus XP';
  }

  @override
  String get greetingsAndIntros => 'GREETINGS\n& INTROS';

  @override
  String holaMeansHello(String hello, String language) {
    return '\"Hola\" means $hello in $language.';
  }

  @override
  String get grammarTip => 'Grammar Tip';

  @override
  String get grammarTipDesc =>
      'Use it any time of the day!\nIt\'s casual and friendly.';

  @override
  String get howDoYouSayHello => 'How do you say \"Hello\"?';

  @override
  String get categories => 'Categories';

  @override
  String get featured => 'Featured';

  @override
  String get specials => 'Specials';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully';

  @override
  String get displayName => 'Display Name';

  @override
  String get enterDisplayName => 'Enter your display name';

  @override
  String get username => 'Username';

  @override
  String get enterUsername => 'Enter your username';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get aboutYou => 'About You';

  @override
  String get enterBio => 'Tell us about yourself';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get adjustPhoto => 'Adjust Photo';

  @override
  String get finish => 'Finish';

  @override
  String get reset => 'Reset';

  @override
  String get camera => 'Camera';

  @override
  String get cameraDescription => 'Take a new photo';

  @override
  String get gallery => 'Gallery';

  @override
  String get galleryDescription => 'Choose a photo from your gallery';

  @override
  String get profilePhoto => 'Profile Photo';

  @override
  String get profileUpdateError => 'Error updating Profile';

  @override
  String get errorNoInternet =>
      'No internet connection. Please check your network.';

  @override
  String get errorNetworkTimeout => 'The request timed out. Please try again.';

  @override
  String get errorConnectionRefused => 'Connection refused by the server.';

  @override
  String get errorSsl => 'Secure connection failed. SSL certificate error.';

  @override
  String get errorNetwork => 'A network error occurred. Please try again.';

  @override
  String get errorInvalidCredentials => 'Invalid email or password.';

  @override
  String get errorTokenExpired =>
      'Your session has expired. Please sign in again.';

  @override
  String get errorTokenInvalid => 'Invalid authentication token.';

  @override
  String get errorSessionExpired => 'Session expired. Please sign in again.';

  @override
  String get errorEmailNotConfirmed =>
      'Please confirm your email address before signing in.';

  @override
  String get errorPhoneNotConfirmed =>
      'Please confirm your phone number before signing in.';

  @override
  String get errorUserNotFound => 'User not found.';

  @override
  String get errorUserAlreadyExists =>
      'An account with this email already exists.';

  @override
  String get errorWeakPassword =>
      'Password is too weak. Use at least 8 characters, including letters and numbers.';

  @override
  String get errorUnauthorized =>
      'You are not authorized to perform this action.';

  @override
  String get errorAccountDisabled =>
      'This account has been disabled. Please contact support.';

  @override
  String get errorRateLimit =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get errorMfaRequired => 'Multi-factor authentication is required.';

  @override
  String get errorInvalidMfaCode => 'Invalid or expired verification code.';

  @override
  String get errorPasswordResetExpired =>
      'Password reset link has expired. Please request a new one.';

  @override
  String get errorAuth => 'An authentication error occurred.';

  @override
  String get errorOAuthNotEnabled =>
      'This social login provider is not enabled in the server settings.';

  @override
  String get errorDuplicateKey => 'A record with this value already exists.';

  @override
  String get errorForeignKeyViolation =>
      'Operation failed due to a related record dependency.';

  @override
  String get errorTransaction =>
      'Database transaction failed and was rolled back.';

  @override
  String get errorEmptyResult => 'No records found for the given query.';

  @override
  String get errorTableNotFound =>
      'The requested database table was not found.';

  @override
  String get errorDatabase => 'A database error occurred.';

  @override
  String get errorInternalServer =>
      'Internal server error. Please try again later.';

  @override
  String get errorServiceUnavailable =>
      'Service is temporarily unavailable. Please try again later.';

  @override
  String get errorBadGateway =>
      'Bad gateway. The server received an invalid response.';

  @override
  String get errorGatewayTimeout =>
      'Gateway timeout. The server took too long to respond.';

  @override
  String get errorApiEndpointNotFound =>
      'The requested API endpoint was not found.';

  @override
  String get errorForbidden =>
      'You do not have permission to access this resource.';

  @override
  String get errorServer => 'A server error occurred. Please try again later.';

  @override
  String get errorCache => 'A local storage error occurred.';

  @override
  String get errorUpload => 'File upload failed. Please try again.';

  @override
  String get errorDownload => 'File download failed. Please try again.';

  @override
  String get errorFileTooLarge => 'File exceeds the maximum allowed size.';

  @override
  String get errorInvalidFileType => 'File type is not allowed.';

  @override
  String get errorFileAlreadyExists => 'A file with this name already exists.';

  @override
  String get errorStorage => 'A storage error occurred.';

  @override
  String get errorRequiredField => 'This field is required.';

  @override
  String get errorMismatch => 'The values do not match.';

  @override
  String get errorValidation => 'Validation failed.';

  @override
  String get errorPermissionDenied =>
      'Permission denied. Please grant access in your device settings.';

  @override
  String get errorPermissionPermanentlyDenied =>
      'Permission permanently denied. Please enable it in your device settings.';

  @override
  String get errorTechnical =>
      'A technical error occurred. Please contact support.';

  @override
  String get errorUnknown => 'An unexpected error occurred.';

  @override
  String get inviteFriendsLabel => 'Invite\nfriends';

  @override
  String get inviteFriendsMessage =>
      'Hi! I\'m using Draksy to learn languages. Join me and let\'s practice together!';

  @override
  String get inviteFriendsURL => 'https://draksy.app';

  @override
  String xpValue(String xp) {
    return '$xp XP';
  }

  @override
  String get progressHistory => 'Progress History';

  @override
  String get viewAllCompletedLessons => 'View all completed lessons';
}
