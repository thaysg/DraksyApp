import 'package:equatable/equatable.dart';

class FeedRankingModel extends Equatable {
  const FeedRankingModel({
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.xp,
    required this.position,
    this.isMe = false,
  });

  factory FeedRankingModel.fromJson(
    Map<String, dynamic> json,
    int position, {
    bool isMe = false,
  }) {
    final id = json['id'] as String? ?? json['userId'] as String? ?? '';
    final photoUrl = json['avatar_url'] as String? ??
        json['picture'] as String? ??
        json['userPhotoUrl'] as String? ??
        '';

    return FeedRankingModel(
      userId: id,
      userName: json['display_name'] as String? ??
          json['full_name'] as String? ??
          json['name'] as String? ??
          json['username'] as String? ??
          'User',
      userPhotoUrl: photoUrl,
      xp: (json['xp'] as int? ?? 0).toString(),
      position: position,
      isMe: isMe,
    );
  }

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
