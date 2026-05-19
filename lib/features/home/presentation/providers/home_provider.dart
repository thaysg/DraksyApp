import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../models/home_view_data.dart';

part 'home_provider.g.dart';

@riverpod
Future<HomeViewData> homeView(Ref ref) async {
  // Watch auth state to get user info
  final user = await ref.watch(authProvider.future);

  // In a real app, these values would be fetched from repositories
  //(stats, lessons, etc.)
  return HomeViewData(
    userName: user?.displayName ?? 'Learner',
    userPhotoUrl: user?.photoURL,
    xp: '2,450',
    level: '14',
    lives: 'Full',
    streak: '12',
    dailyChallenge: const HomeDailyChallengeData(
      title: 'Master Past Tense',
      subtitle: 'New Grammar',
      progress: 0.2,
      lessonsCompleted: 0,
    ),
    lessons: const [
      HomeLessonData(
        title: 'Food & Dining',
        subtitle:
            // Ideally formatted via l10n in the UI or passed as raw data
            'Unit 3, Lesson 2',
        emoji: '🍔',
        progress: 0.6,
        iconBgColor: AppColors.accent,
      ),
      HomeLessonData(
        title: 'Travel',
        subtitle: 'Unit 4, Lesson 1',
        emoji: '✈️',
        progress: 0.15,
        iconBgColor: AppColors.mana,
      ),
    ],
  );
}
