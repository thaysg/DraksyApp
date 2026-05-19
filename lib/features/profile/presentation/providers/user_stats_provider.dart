import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';

part 'user_stats_provider.g.dart';

class UserStats {
  const UserStats({
    required this.lives,
    required this.xp,
    required this.gems,
  });

  final int lives;
  final int xp;
  final int gems;

  UserStats copyWith({
    int? lives,
    int? xp,
    int? gems,
  }) =>
      UserStats(
        lives: lives ?? this.lives,
        xp: xp ?? this.xp,
        gems: gems ?? this.gems,
      );
}

@Riverpod(keepAlive: true)
class UserStatsNotifier extends _$UserStatsNotifier {
  @override
  UserStats build() => const UserStats(
        lives: AppConstants.maxLives,
        xp: 0,
        gems: 0,
      );

  void reduceLife() {
    if (state.lives > 0) {
      state = state.copyWith(lives: state.lives - 1);
    }
  }

  void addXp(int amount) {
    state = state.copyWith(xp: state.xp + amount);
  }

  void resetLives() {
    state = state.copyWith(lives: AppConstants.maxLives);
  }
}
