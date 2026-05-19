import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the Draksy system.
class User extends Equatable {
  /// Creates a new [User] instance
  const User({
    required this.id,
    required this.email,
    required this.createdAt,
    this.displayName,
    this.photoURL,
    this.bio,
    this.isPremium = false,
  });

  /// Unique identifier for the user
  final String id;

  /// User's email address
  final String email;

  /// User's display name
  final String? displayName;

  /// URL to the user's profile photo
  final String? photoURL;

  /// User's short biography or description
  final String? bio;

  /// Whether the user has a premium subscription
  final bool isPremium;

  /// Date and time when the account was created
  final DateTime createdAt;

  @override
  List<Object?> get props =>
      [id, email, displayName, photoURL, bio, isPremium, createdAt];
}
