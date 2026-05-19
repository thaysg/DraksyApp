import 'package:equatable/equatable.dart';

class FeedActivityModel extends Equatable {
  const FeedActivityModel({
    required this.id,
    required this.userName,
    required this.userPhotoUrl,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.likes,
    required this.value,
    this.isOnline = false,
    this.isLiked = false,
  });

  factory FeedActivityModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>? ?? {};
    final photoUrl = profile['avatar_url'] as String? ??
        profile['picture'] as String? ??
        profile['photo_url'] as String? ??
        '';

    return FeedActivityModel(
      id: json['id'] as String,
      userName: profile['display_name'] as String? ??
          profile['full_name'] as String? ??
          profile['name'] as String? ??
          profile['username'] as String? ??
          'User',
      userPhotoUrl: photoUrl,
      type: json['type'] as String,
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      likes: json['likes'] as int? ?? 0,
      value: json['value'] as String? ?? '',
      isOnline: profile['is_online'] as bool? ?? false,
      isLiked: json['is_liked'] as bool? ?? false,
    );
  }

  final String id;
  final String userName;
  final String userPhotoUrl;
  final String type;
  final String description;
  final DateTime createdAt;
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
        createdAt,
        likes,
        value,
        isOnline,
        isLiked,
      ];
}
