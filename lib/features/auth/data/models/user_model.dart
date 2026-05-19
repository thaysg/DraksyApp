import '../../domain/entities/user.dart';

/// Data model for [User] entity.
class UserModel extends User {
  /// Creates a new [UserModel] instance.
  const UserModel({
    required super.id,
    required super.email,
    required super.createdAt,
    super.displayName,
    super.photoURL,
    super.bio,
    super.isPremium,
  });

  /// Creates a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        email: json['email'] as String,
        displayName: json['displayName'] as String?,
        photoURL: json['photoURL'] as String?,
        bio: json['bio'] as String?,
        isPremium: json['isPremium'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
        'bio': bio,
        'isPremium': isPremium,
        'createdAt': createdAt.toIso8601String(),
      };
}
