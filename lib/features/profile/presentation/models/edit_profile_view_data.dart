import 'package:equatable/equatable.dart';

/// UI-ready data for the Edit Profile screen.
class EditProfileViewData extends Equatable {
  const EditProfileViewData({
    required this.displayName,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.bio,
    required this.level,
  });

  final String displayName;
  final String username;
  final String email;
  final String photoUrl;
  final String bio;
  final int level;

  static const mock = EditProfileViewData(
    displayName: 'User Name',
    username: '@username',
    email: 'user@example.com',
    photoUrl: '',
    bio: 'Bio goes here...',
    level: 1,
  );

  @override
  List<Object?> get props => [
        displayName,
        username,
        email,
        photoUrl,
        bio,
        level,
      ];
}
