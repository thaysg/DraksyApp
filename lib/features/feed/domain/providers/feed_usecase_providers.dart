import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/feed_repository_providers.dart';
import '../usecases/get_activities.dart';
import '../usecases/get_friends.dart';
import '../usecases/get_weekly_challenge.dart';
import '../usecases/get_weekly_leaderboard.dart';

part 'feed_usecase_providers.g.dart';

@riverpod
GetActivities getActivities(Ref ref) {
  final repository = ref.watch(feedRepositoryProvider);
  return GetActivities(repository);
}

@riverpod
GetFriends getFriends(Ref ref) {
  final repository = ref.watch(feedRepositoryProvider);
  return GetFriends(repository);
}

@riverpod
GetWeeklyChallenge getWeeklyChallenge(Ref ref) {
  final repository = ref.watch(feedRepositoryProvider);
  return GetWeeklyChallenge(repository);
}

@riverpod
GetWeeklyLeaderboard getWeeklyLeaderboard(Ref ref) {
  final repository = ref.watch(feedRepositoryProvider);
  return GetWeeklyLeaderboard(repository);
}
