import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Draksy'**
  String get appName;

  /// Link to return to sign in page
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// Message indicating confirmation email was sent
  ///
  /// In en, this message translates to:
  /// **'Confirmation sent to {email}'**
  String confirmationSentTo(String email);

  /// Instruction to click confirmation link
  ///
  /// In en, this message translates to:
  /// **'Click the confirmation link in the email to complete your registration'**
  String get clickConfirmationLink;

  /// Title for email confirmation screen
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// Title for the feed screen
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get feedTitle;

  /// Subtitle for the feed screen
  ///
  /// In en, this message translates to:
  /// **'See the community\'s performance'**
  String get feedSubtitle;

  /// Label for the current user in stories/feed
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// Label for weekly challenge section
  ///
  /// In en, this message translates to:
  /// **'Weekly Challenge'**
  String get weeklyChallenge;

  /// Description for weekly challenge
  ///
  /// In en, this message translates to:
  /// **'Complete 30 lessons this week and earn a reward!'**
  String get weeklyChallengeDesc;

  /// Label for weekly ranking section
  ///
  /// In en, this message translates to:
  /// **'Weekly Ranking'**
  String get weeklyRanking;

  /// Activity feed: user completed a lesson
  ///
  /// In en, this message translates to:
  /// **'{name} completed a lesson'**
  String activityCompletedLesson(String name);

  /// Activity feed: user reached a new level
  ///
  /// In en, this message translates to:
  /// **'{name} reached a new level'**
  String activityReachedLevel(String name);

  /// Activity feed: user maintained streak
  ///
  /// In en, this message translates to:
  /// **'{name} maintained the streak'**
  String activityMaintainedStreak(String name);

  /// Activity feed: user won an achievement
  ///
  /// In en, this message translates to:
  /// **'{name} won an achievement'**
  String activityWonAchievement(String name);

  /// Activity feed: current level status
  ///
  /// In en, this message translates to:
  /// **'Now at level {level}!'**
  String nowLevel(int level);

  /// Activity feed: days streak count
  ///
  /// In en, this message translates to:
  /// **'{count} day streak!'**
  String daysStreak(int count);

  /// Activity feed: time since activity occurred
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String timeAgo(String time);

  /// Generic OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Generic cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Generic close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Generic retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Loading state text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Generic error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Generic success label
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Welcome message on splash screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Draksy'**
  String get welcome;

  /// Welcome message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeUser(String name);

  /// Sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Google sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// Email input label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password input label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// World map page title
  ///
  /// In en, this message translates to:
  /// **'World Map'**
  String get worldMap;

  /// Lessons page title
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// Battle page title
  ///
  /// In en, this message translates to:
  /// **'Battle'**
  String get battle;

  /// Levels generic label
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get levels;

  /// Current level indicator
  ///
  /// In en, this message translates to:
  /// **'Level {number}'**
  String level(int number);

  /// Experience points abbreviation
  ///
  /// In en, this message translates to:
  /// **'XP'**
  String get xp;

  /// XP progress display
  ///
  /// In en, this message translates to:
  /// **'{current} / {max} XP'**
  String xpProgress(int current, int max);

  /// Lives generic label
  ///
  /// In en, this message translates to:
  /// **'Lives'**
  String get lives;

  /// Lives remaining indicator
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No lives} =1{1 life} other{{count} lives}}'**
  String livesRemaining(int count);

  /// Streak generic label
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// Current streak display
  ///
  /// In en, this message translates to:
  /// **'{count} day streak'**
  String streakDays(int count);

  /// Coins generic label
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// World indicator
  ///
  /// In en, this message translates to:
  /// **'World {number}'**
  String world(int number);

  /// Lesson indicator
  ///
  /// In en, this message translates to:
  /// **'Lesson {number}'**
  String lesson(int number);

  /// Locked state indicator
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// Unlocked state indicator
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// Completed state indicator
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Boss generic label
  ///
  /// In en, this message translates to:
  /// **'Boss'**
  String get boss;

  /// Defeat action button
  ///
  /// In en, this message translates to:
  /// **'Defeat'**
  String get defeat;

  /// Exercise generic label
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise;

  /// Question generic label
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// Answer generic label
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Correct answer feedback
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// Incorrect answer feedback
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// Profile page title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Statistics page title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// Total experience points label
  ///
  /// In en, this message translates to:
  /// **'Total XP'**
  String get totalXp;

  /// Achievements page title
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// Premium tier label
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// Free tier label
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// Premium upgrade button
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get buyPremium;

  /// Lives pack price
  ///
  /// In en, this message translates to:
  /// **'R\$ 4,90'**
  String get livesPackPrice;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// Title for out of lives dialog
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get noLivesTitle;

  /// Message for out of lives dialog
  ///
  /// In en, this message translates to:
  /// **'You\'ve lost all your lives. Try again later!'**
  String get noLivesMessage;

  /// Title for successful lesson completion
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get lessonCompletedTitle;

  /// Title for failed lesson completion
  ///
  /// In en, this message translates to:
  /// **'Not this time!'**
  String get lessonFailedTitle;

  /// Message for successful lesson completion
  ///
  /// In en, this message translates to:
  /// **'You did great and unlocked the next lesson!'**
  String get lessonCompletedMessage;

  /// Message for failed lesson completion
  ///
  /// In en, this message translates to:
  /// **'Review the lesson and try again to reach 80% accuracy.'**
  String get lessonFailedMessage;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// Try again button
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Intro screen 1 title
  ///
  /// In en, this message translates to:
  /// **'Draksy'**
  String get introTitle1;

  /// Intro screen 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'Master languages with your\nAI buddy'**
  String get introSubtitle1;

  /// Intro screen 2 title
  ///
  /// In en, this message translates to:
  /// **'Learn languages in a fun\nand gamified way'**
  String get introTitle2;

  /// Intro screen 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'Interactive exercises, daily quests,\nand your personal AI buddy make\nfluency feel like playing.'**
  String get introSubtitle2;

  /// Intro screen 3 title
  ///
  /// In en, this message translates to:
  /// **'Track progress, streaks,\nand rewards'**
  String get introTitle3;

  /// Intro screen 3 subtitle
  ///
  /// In en, this message translates to:
  /// **'Build daily habits, unlock exclusive\nbadges, and watch your language\nskills level up every single day.'**
  String get introSubtitle3;

  /// Intro screen 4 title
  ///
  /// In en, this message translates to:
  /// **'Practice daily and\nimprove fast'**
  String get introTitle4;

  /// Intro screen 4 subtitle
  ///
  /// In en, this message translates to:
  /// **'Commit to just 10 minutes a day.\nConsistent practice is the key to\nmastering any language.'**
  String get introSubtitle4;

  /// Intro get started button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get introGetStarted;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Already have account prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Don't have account prompt
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Log in link
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// Welcome back heading
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// Create account heading
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Sign in to continue subtitle
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get signInToContinue;

  /// Join us to start subtitle
  ///
  /// In en, this message translates to:
  /// **'Join us to start your journey today'**
  String get joinUsToStart;

  /// Name input placeholder
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// Email input placeholder
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get yourEmail;

  /// Password input placeholder
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get yourPassword;

  /// Create password placeholder
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get createPassword;

  /// Confirm password label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Error message when passwords don't match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Or continue with divider
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get orContinueWith;

  /// Or sign up with divider
  ///
  /// In en, this message translates to:
  /// **'OR SIGN UP WITH'**
  String get orSignUpWith;

  /// Terms of service link
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms agreement text
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to our {tos} and {privacy}.'**
  String byCreatingAccount(String tos, String privacy);

  /// Full name label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Sign in with Apple button
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Good morning greeting label
  ///
  /// In en, this message translates to:
  /// **'GOOD MORNING'**
  String get goodMorning;

  /// Good afternoon greeting label
  ///
  /// In en, this message translates to:
  /// **'GOOD AFTERNOON'**
  String get goodAfternoon;

  /// Good evening greeting label
  ///
  /// In en, this message translates to:
  /// **'GOOD EVENING'**
  String get goodEvening;

  /// Daily challenge section title
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyChallenge;

  /// Continue learning section title
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get continueLearning;

  /// New grammar label
  ///
  /// In en, this message translates to:
  /// **'New Grammar'**
  String get newGrammar;

  /// Start challenge button
  ///
  /// In en, this message translates to:
  /// **'Start Challenge'**
  String get startChallenge;

  /// Resume button
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// See all button
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Shop tab label
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// Unit and lesson indicator
  ///
  /// In en, this message translates to:
  /// **'Unit {unit} • Lesson {lesson}'**
  String unitLesson(int unit, int lesson);

  /// Lives full label
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get livesFull;

  /// Master past tense card title
  ///
  /// In en, this message translates to:
  /// **'Master the\nPast Tense'**
  String get masterPastTense;

  /// Progress label
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// Lessons count label
  ///
  /// In en, this message translates to:
  /// **'{count} Lessons'**
  String lessonsCount(int count);

  /// Premium membership label
  ///
  /// In en, this message translates to:
  /// **'Premium Membership'**
  String get premiumMembership;

  /// Annual plan label
  ///
  /// In en, this message translates to:
  /// **'Annual Plan'**
  String get annualPlan;

  /// Monthly plan label
  ///
  /// In en, this message translates to:
  /// **'Monthly Plan'**
  String get monthlyPlan;

  /// Best value badge
  ///
  /// In en, this message translates to:
  /// **'BEST VALUE'**
  String get bestValue;

  /// Per year suffix
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get perYear;

  /// Per month suffix
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// Unlimited hearts feature
  ///
  /// In en, this message translates to:
  /// **'Unlimited Hearts'**
  String get unlimitedHearts;

  /// No ads feature
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get noAds;

  /// Offline access feature
  ///
  /// In en, this message translates to:
  /// **'Offline Access'**
  String get offlineAccess;

  /// Monthly streak repair feature
  ///
  /// In en, this message translates to:
  /// **'Monthly Streak Repair'**
  String get monthlyStreakRepair;

  /// Start free trial button
  ///
  /// In en, this message translates to:
  /// **'Start 14-Day Free Trial'**
  String get startFreeTrial;

  /// Subscribe monthly button
  ///
  /// In en, this message translates to:
  /// **'Subscribe Monthly'**
  String get subscribeMonthly;

  /// Power-ups section title
  ///
  /// In en, this message translates to:
  /// **'Power-ups'**
  String get powerUps;

  /// Refill hearts item title
  ///
  /// In en, this message translates to:
  /// **'Refill Hearts'**
  String get refillHearts;

  /// Refill hearts item subtitle
  ///
  /// In en, this message translates to:
  /// **'Get back in the game'**
  String get getBackInTheGame;

  /// Streak freeze item title
  ///
  /// In en, this message translates to:
  /// **'Streak Freeze'**
  String get streakFreeze;

  /// Streak freeze item subtitle
  ///
  /// In en, this message translates to:
  /// **'Protect your streak for 1 day'**
  String get protectYourStreak;

  /// Purchase button
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// Buy button
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// Refill hearts amount label
  ///
  /// In en, this message translates to:
  /// **'{amount} Hearts'**
  String refillHeartsAmount(int amount);

  /// Edit profile button
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Learning stats section title
  ///
  /// In en, this message translates to:
  /// **'Learning Stats'**
  String get learningStats;

  /// Accuracy stat label
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// Badges section title
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// Manage badges button
  ///
  /// In en, this message translates to:
  /// **'Manage Badges'**
  String get manageBadges;

  /// Draksy premium label
  ///
  /// In en, this message translates to:
  /// **'Draksy Premium'**
  String get draksyPremium;

  /// Manage subscription button
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get manageSubscription;

  /// Invite friends menu item
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get inviteFriends;

  /// Invite friends reward subtitle
  ///
  /// In en, this message translates to:
  /// **'Get 1 week free Premium!'**
  String get inviteFriendsReward;

  /// Help and support menu item
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// FAQ and contact subtitle
  ///
  /// In en, this message translates to:
  /// **'FAQ and contact'**
  String get faqContact;

  /// Notifications menu item
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Mock user display name
  ///
  /// In en, this message translates to:
  /// **'Alex Dragonheart'**
  String get mockUserName;

  /// Mock user tag
  ///
  /// In en, this message translates to:
  /// **'@alex_learns'**
  String get mockUserTag;

  /// English language label
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Spanish language label
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// Intermediate level label
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// Beginner level label
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// Champion badge title
  ///
  /// In en, this message translates to:
  /// **'Champion'**
  String get champion;

  /// Top 10 badge subtitle
  ///
  /// In en, this message translates to:
  /// **'Top 10%'**
  String get top10;

  /// On fire badge title
  ///
  /// In en, this message translates to:
  /// **'On Fire'**
  String get onFire;

  /// 30 day streak badge subtitle
  ///
  /// In en, this message translates to:
  /// **'30 Day Streak'**
  String get thirtyDayStreak;

  /// Master badge title
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get master;

  /// Account settings section
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Change password subtitle
  ///
  /// In en, this message translates to:
  /// **'Change your password'**
  String get changePassword;

  /// Learning and goals settings section
  ///
  /// In en, this message translates to:
  /// **'Learning & Goals'**
  String get learningGoals;

  /// Daily goal setting
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get dailyGoal;

  /// XP per day label
  ///
  /// In en, this message translates to:
  /// **'{xp} XP per day'**
  String xpPerDay(int xp);

  /// Practice reminders setting
  ///
  /// In en, this message translates to:
  /// **'Practice Reminders'**
  String get practiceReminders;

  /// Daily reminder time label
  ///
  /// In en, this message translates to:
  /// **'Daily at {time}'**
  String dailyAt(String time);

  /// Difficulty setting
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// Audio settings section
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// Sound effects setting
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// Voice speed setting
  ///
  /// In en, this message translates to:
  /// **'Voice Speed'**
  String get voiceSpeed;

  /// Normal speed label
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// Delete account button
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Title for delete account confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountTitle;

  /// Message for delete account confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone and you will lose all your progress.'**
  String get deleteAccountMessage;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// General settings section
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Preferences settings section
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Sound setting
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// Haptics setting
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// Terms and privacy menu item
  ///
  /// In en, this message translates to:
  /// **'Terms & Privacy'**
  String get termsPrivacy;

  /// Advanced settings section
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// All categories filter
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// Grammar category
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get grammar;

  /// Vocabulary category
  ///
  /// In en, this message translates to:
  /// **'Vocabulary'**
  String get vocabulary;

  /// Beginner level description
  ///
  /// In en, this message translates to:
  /// **'Basics, greetings, and simple sentences.'**
  String get beginnerDesc;

  /// Intermediate level description
  ///
  /// In en, this message translates to:
  /// **'Complex grammar and daily conversations.'**
  String get intermediateDesc;

  /// Advanced level description
  ///
  /// In en, this message translates to:
  /// **'Fluent speaking and professional vocabulary.'**
  String get advancedDesc;

  /// Time per lesson label
  ///
  /// In en, this message translates to:
  /// **'~{minutes} mins/lesson'**
  String timePerLesson(int minutes);

  /// Category progress label
  ///
  /// In en, this message translates to:
  /// **'Category Progress'**
  String get categoryProgress;

  /// Units count label
  ///
  /// In en, this message translates to:
  /// **'{current}/{total} Lessons'**
  String unitsCount(int current, int total);

  /// Unit number label
  ///
  /// In en, this message translates to:
  /// **'Lesson {number}'**
  String unitNumber(int number);

  /// Next unit label
  ///
  /// In en, this message translates to:
  /// **'NEXT: LESSON {number}'**
  String nextUnit(int number);

  /// Section cleared message
  ///
  /// In en, this message translates to:
  /// **'Section {number} Cleared!'**
  String sectionCleared(int number);

  /// Bonus XP earned message
  ///
  /// In en, this message translates to:
  /// **'You earned {xp} bonus XP'**
  String bonusXpEarned(int xp);

  /// Greetings and introductions unit label
  ///
  /// In en, this message translates to:
  /// **'GREETINGS\n& INTROS'**
  String get greetingsAndIntros;

  /// Hola means hello exercise text
  ///
  /// In en, this message translates to:
  /// **'\"Hola\" means {hello} in {language}.'**
  String holaMeansHello(String hello, String language);

  /// Grammar tip label
  ///
  /// In en, this message translates to:
  /// **'Grammar Tip'**
  String get grammarTip;

  /// Grammar tip description text
  ///
  /// In en, this message translates to:
  /// **'Use it any time of the day!\nIt\'s casual and friendly.'**
  String get grammarTipDesc;

  /// How do you say hello exercise question
  ///
  /// In en, this message translates to:
  /// **'How do you say \"Hello\"?'**
  String get howDoYouSayHello;

  /// Categories label
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Featured section label
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// Specials section label
  ///
  /// In en, this message translates to:
  /// **'Specials'**
  String get specials;

  /// Snackbar message after saving profile
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// Display name label in edit profile
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// Placeholder for display name input
  ///
  /// In en, this message translates to:
  /// **'Enter your display name'**
  String get enterDisplayName;

  /// Username label in edit profile
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Placeholder for username input
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterUsername;

  /// Placeholder for email input
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// About you section label in edit profile
  ///
  /// In en, this message translates to:
  /// **'About You'**
  String get aboutYou;

  /// Placeholder for bio/about you input
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get enterBio;

  /// Save changes button
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Title for image cropping screen
  ///
  /// In en, this message translates to:
  /// **'Adjust Photo'**
  String get adjustPhoto;

  /// Finish button label
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Reset button label
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Camera source for image picking
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Description for camera source
  ///
  /// In en, this message translates to:
  /// **'Take a new photo'**
  String get cameraDescription;

  /// Gallery source for image picking
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Description for gallery source
  ///
  /// In en, this message translates to:
  /// **'Choose a photo from your gallery'**
  String get galleryDescription;

  /// Profile photo section label
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profilePhoto;

  /// Profile error message
  ///
  /// In en, this message translates to:
  /// **'Error updating Profile'**
  String get profileUpdateError;

  /// No internet error message
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network.'**
  String get errorNoInternet;

  /// Network timeout error message
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again.'**
  String get errorNetworkTimeout;

  /// Connection refused error message
  ///
  /// In en, this message translates to:
  /// **'Connection refused by the server.'**
  String get errorConnectionRefused;

  /// SSL error message
  ///
  /// In en, this message translates to:
  /// **'Secure connection failed. SSL certificate error.'**
  String get errorSsl;

  /// Generic network error message
  ///
  /// In en, this message translates to:
  /// **'A network error occurred. Please try again.'**
  String get errorNetwork;

  /// Invalid credentials error message
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get errorInvalidCredentials;

  /// Token expired error message
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get errorTokenExpired;

  /// Token invalid error message
  ///
  /// In en, this message translates to:
  /// **'Invalid authentication token.'**
  String get errorTokenInvalid;

  /// Session expired error message
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please sign in again.'**
  String get errorSessionExpired;

  /// Email not confirmed error message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your email address before signing in.'**
  String get errorEmailNotConfirmed;

  /// Phone not confirmed error message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your phone number before signing in.'**
  String get errorPhoneNotConfirmed;

  /// User not found error message
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get errorUserNotFound;

  /// User already exists error message
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get errorUserAlreadyExists;

  /// Weak password error message
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 8 characters, including letters and numbers.'**
  String get errorWeakPassword;

  /// Unauthorized error message
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to perform this action.'**
  String get errorUnauthorized;

  /// Account disabled error message
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Please contact support.'**
  String get errorAccountDisabled;

  /// Rate limit error message
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment and try again.'**
  String get errorRateLimit;

  /// MFA required error message
  ///
  /// In en, this message translates to:
  /// **'Multi-factor authentication is required.'**
  String get errorMfaRequired;

  /// Invalid MFA code error message
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired verification code.'**
  String get errorInvalidMfaCode;

  /// Password reset expired error message
  ///
  /// In en, this message translates to:
  /// **'Password reset link has expired. Please request a new one.'**
  String get errorPasswordResetExpired;

  /// Generic auth error message
  ///
  /// In en, this message translates to:
  /// **'An authentication error occurred.'**
  String get errorAuth;

  /// OAuth provider not enabled error message
  ///
  /// In en, this message translates to:
  /// **'This social login provider is not enabled in the server settings.'**
  String get errorOAuthNotEnabled;

  /// Duplicate key error message
  ///
  /// In en, this message translates to:
  /// **'A record with this value already exists.'**
  String get errorDuplicateKey;

  /// Foreign key violation error message
  ///
  /// In en, this message translates to:
  /// **'Operation failed due to a related record dependency.'**
  String get errorForeignKeyViolation;

  /// Transaction error message
  ///
  /// In en, this message translates to:
  /// **'Database transaction failed and was rolled back.'**
  String get errorTransaction;

  /// Empty result error message
  ///
  /// In en, this message translates to:
  /// **'No records found for the given query.'**
  String get errorEmptyResult;

  /// Table not found error message
  ///
  /// In en, this message translates to:
  /// **'The requested database table was not found.'**
  String get errorTableNotFound;

  /// Generic database error message
  ///
  /// In en, this message translates to:
  /// **'A database error occurred.'**
  String get errorDatabase;

  /// Internal server error message
  ///
  /// In en, this message translates to:
  /// **'Internal server error. Please try again later.'**
  String get errorInternalServer;

  /// Service unavailable error message
  ///
  /// In en, this message translates to:
  /// **'Service is temporarily unavailable. Please try again later.'**
  String get errorServiceUnavailable;

  /// Bad gateway error message
  ///
  /// In en, this message translates to:
  /// **'Bad gateway. The server received an invalid response.'**
  String get errorBadGateway;

  /// Gateway timeout error message
  ///
  /// In en, this message translates to:
  /// **'Gateway timeout. The server took too long to respond.'**
  String get errorGatewayTimeout;

  /// API endpoint not found error message
  ///
  /// In en, this message translates to:
  /// **'The requested API endpoint was not found.'**
  String get errorApiEndpointNotFound;

  /// Forbidden error message
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access this resource.'**
  String get errorForbidden;

  /// Generic server error message
  ///
  /// In en, this message translates to:
  /// **'A server error occurred. Please try again later.'**
  String get errorServer;

  /// Generic cache error message
  ///
  /// In en, this message translates to:
  /// **'A local storage error occurred.'**
  String get errorCache;

  /// Upload error message
  ///
  /// In en, this message translates to:
  /// **'File upload failed. Please try again.'**
  String get errorUpload;

  /// Download error message
  ///
  /// In en, this message translates to:
  /// **'File download failed. Please try again.'**
  String get errorDownload;

  /// File too large error message
  ///
  /// In en, this message translates to:
  /// **'File exceeds the maximum allowed size.'**
  String get errorFileTooLarge;

  /// Invalid file type error message
  ///
  /// In en, this message translates to:
  /// **'File type is not allowed.'**
  String get errorInvalidFileType;

  /// File already exists error message
  ///
  /// In en, this message translates to:
  /// **'A file with this name already exists.'**
  String get errorFileAlreadyExists;

  /// Generic storage error message
  ///
  /// In en, this message translates to:
  /// **'A storage error occurred.'**
  String get errorStorage;

  /// Required field error message
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get errorRequiredField;

  /// Mismatch error message
  ///
  /// In en, this message translates to:
  /// **'The values do not match.'**
  String get errorMismatch;

  /// Generic validation error message
  ///
  /// In en, this message translates to:
  /// **'Validation failed.'**
  String get errorValidation;

  /// Permission denied error message
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Please grant access in your device settings.'**
  String get errorPermissionDenied;

  /// Permission permanently denied error message
  ///
  /// In en, this message translates to:
  /// **'Permission permanently denied. Please enable it in your device settings.'**
  String get errorPermissionPermanentlyDenied;

  /// Technical error message
  ///
  /// In en, this message translates to:
  /// **'A technical error occurred. Please contact support.'**
  String get errorTechnical;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errorUnknown;

  /// Invite friends label with line break
  ///
  /// In en, this message translates to:
  /// **'Invite\nfriends'**
  String get inviteFriendsLabel;

  /// Default message for inviting friends
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m using Draksy to learn languages. Join me and let\'s practice together!'**
  String get inviteFriendsMessage;

  /// Default URL for inviting friends
  ///
  /// In en, this message translates to:
  /// **'https://draksy.app'**
  String get inviteFriendsURL;

  /// XP value label
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String xpValue(String xp);

  /// Progress history page title
  ///
  /// In en, this message translates to:
  /// **'Progress History'**
  String get progressHistory;

  /// Subtitle for progress history menu item
  ///
  /// In en, this message translates to:
  /// **'View all completed lessons'**
  String get viewAllCompletedLessons;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
