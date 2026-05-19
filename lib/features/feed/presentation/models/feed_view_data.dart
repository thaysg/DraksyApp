import 'package:equatable/equatable.dart';

/// Story data for the Feed top section.
class FeedStoryData extends Equatable {
  const FeedStoryData({
    required this.name,
    required this.photoUrl,
    required this.isMe,
    required this.isOnline,
    required this.hasUpdate,
  });

  final String name;
  final String photoUrl;
  final bool isMe;
  final bool isOnline;
  final bool hasUpdate;

  @override
  List<Object?> get props => [name, photoUrl, isMe, isOnline, hasUpdate];
}

/// Data for the weekly challenge card.
class FeedWeeklyChallengeData extends Equatable {
  const FeedWeeklyChallengeData({
    required this.title,
    required this.description,
    required this.completedLessons,
    required this.totalLessons,
    required this.remainingTime,
  });

  final String title;
  final String description;
  final int completedLessons;
  final int totalLessons;
  final String remainingTime;

  double get progress => completedLessons / totalLessons;

  @override
  List<Object?> get props => [
        title,
        description,
        completedLessons,
        totalLessons,
        remainingTime,
      ];
}

/// Types of activity in the feed.
enum FeedActivityType { lesson, level, streak, achievement }

/// Data for an activity item in the feed.
class FeedActivityData extends Equatable {
  const FeedActivityData({
    required this.id,
    required this.userName,
    required this.userPhotoUrl,
    required this.type,
    required this.description,
    required this.timeAgo,
    required this.likes,
    required this.value,
    this.isOnline = false,
    this.isLiked = false,
  });

  final String id;
  final String userName;
  final String userPhotoUrl;
  final FeedActivityType type;
  final String description;
  final String timeAgo;
  final int likes;
  final String value;
  final bool isOnline;
  final bool isLiked;

  @override
  List<Object?> get props => [
        id,
        userName,
        userPhotoUrl,
        type,
        description,
        timeAgo,
        likes,
        value,
        isOnline,
        isLiked,
      ];
}

/// Data for a ranking item.
class FeedRankingData extends Equatable {
  const FeedRankingData({
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.xp,
    required this.position,
    this.isMe = false,
  });

  final String userId;
  final String userName;
  final String userPhotoUrl;
  final String xp;
  final int position;
  final bool isMe;

  @override
  List<Object?> get props => [
        userId,
        userName,
        userPhotoUrl,
        xp,
        position,
        isMe,
      ];
}

/// Main view data for the Feed screen.
class FeedViewData extends Equatable {
  const FeedViewData({
    required this.stories,
    required this.weeklyChallenge,
    required this.rankings,
  });

  final List<FeedStoryData> stories;
  final FeedWeeklyChallengeData weeklyChallenge;
  final List<FeedRankingData> rankings;

  static const mockActivities = [
    FeedActivityData(
      id: '1',
      userName: 'Ana Clara',
      userPhotoUrl: 'https://i.pravatar.cc/150?u=ana',
      type: FeedActivityType.lesson,
      description: 'Discutindo o clima 🌧️',
      timeAgo: '2h',
      likes: 24,
      value: '+50',
    ),
    FeedActivityData(
      id: '2',
      userName: 'Lucas',
      userPhotoUrl: 'https://i.pravatar.cc/150?u=lucas',
      type: FeedActivityType.level,
      description: 'Agora é nível 12! 🌟',
      timeAgo: '3h',
      likes: 31,
      value: 'Nível 12',
      isOnline: true,
      isLiked: true,
    ),
    FeedActivityData(
      id: '3',
      userName: 'Matheus',
      userPhotoUrl: 'https://i.pravatar.cc/150?u=matheus',
      type: FeedActivityType.streak,
      description: '30 dias de sequência! 🔥',
      timeAgo: '5h',
      likes: 18,
      value: '30 dias',
      isOnline: true,
    ),
    FeedActivityData(
      id: '4',
      userName: 'Juliana',
      userPhotoUrl: 'https://i.pravatar.cc/150?u=juliana',
      type: FeedActivityType.achievement,
      description: 'Mestre do Clima',
      timeAgo: '6h',
      likes: 42,
      value: 'shield',
      isLiked: true,
    ),
  ];

  static const mock = FeedViewData(
    stories: [
      FeedStoryData(
        name: 'Você',
        photoUrl: 'https://i.pravatar.cc/150?u=me',
        isMe: true,
        isOnline: true,
        hasUpdate: true,
      ),
      FeedStoryData(
        name: 'Ana Clara',
        photoUrl: 'https://i.pravatar.cc/150?u=ana',
        isMe: false,
        isOnline: false,
        hasUpdate: true,
      ),
      FeedStoryData(
        name: 'Lucas',
        photoUrl: 'https://i.pravatar.cc/150?u=lucas',
        isMe: false,
        isOnline: true,
        hasUpdate: true,
      ),
      FeedStoryData(
        name: 'Matheus',
        photoUrl: 'https://i.pravatar.cc/150?u=matheus',
        isMe: false,
        isOnline: false,
        hasUpdate: true,
      ),
    ],
    weeklyChallenge: FeedWeeklyChallengeData(
      title: 'Desafio Semanal',
      description: 'Complete 30 lições essa semana e ganhe uma recompensa!',
      completedLessons: 21,
      totalLessons: 30,
      remainingTime: '5d 14h',
    ),
    rankings: [
      FeedRankingData(
        userId: 'ranking-1',
        userName: 'Ana Clara',
        userPhotoUrl: 'https://i.pravatar.cc/150?u=ana',
        xp: '2.450',
        position: 2,
      ),
      FeedRankingData(
        userId: 'ranking-2',
        userName: 'Lucas',
        userPhotoUrl: 'https://i.pravatar.cc/150?u=lucas',
        xp: '3.200',
        position: 1,
      ),
      FeedRankingData(
        userId: 'ranking-3',
        userName: 'Matheus',
        userPhotoUrl: 'https://i.pravatar.cc/150?u=matheus',
        xp: '1.870',
        position: 3,
      ),
    ],
  );

  @override
  List<Object?> get props => [stories, weeklyChallenge, rankings];
}
