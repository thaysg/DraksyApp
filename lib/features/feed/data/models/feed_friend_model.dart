import 'package:equatable/equatable.dart';

class FeedFriendModel extends Equatable {
  const FeedFriendModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.isMe,
    required this.isOnline,
    required this.hasUpdate,
    required this.streak,
  });

  factory FeedFriendModel.fromJson(Map<String, dynamic> json) {
    final photoUrl = json['avatar_url'] as String? ?? 
                    json['picture'] as String? ??
                    json['photo_url'] as String? ?? '';
    final id = json['id'] as String;
    
    return FeedFriendModel(
        id: id,
        name: json['display_name'] as String? ??
              json['full_name'] as String? ??
              json['name'] as String? ??
              json['username'] as String? ??
              'User',
        photoUrl: photoUrl,
        isMe: json['is_me'] as bool? ?? false,
        isOnline: json['is_online'] as bool? ?? false,
        hasUpdate: json['has_update'] as bool? ?? false,
        streak: json['streak'] as int? ?? 0,
      );
  }

  final String id;
  final String name;
  final String photoUrl;
  final bool isMe;
  final bool isOnline;
  final bool hasUpdate;
  final int streak;

  @override
  List<Object?> get props =>
      [id, name, photoUrl, isMe, isOnline, hasUpdate, streak];
}
