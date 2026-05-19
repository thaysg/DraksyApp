import 'dart:typed_data';

import 'package:strawti_utils/strawti_utils.dart';

import '../entities/user.dart';

/// Repository interface for authentication operations.
abstract class AuthRepository {
  /// Signs in the user with Google.
  FStrautilsResponse<User> signInWithGoogle();

  /// Signs in with email and password.
  FStrautilsResponse<User> signInWithEmailAndPassword(
    String email,
    String password,
  );

  /// Signs up with email and password.
  FStrautilsResponse<User> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  );

  /// Signs out the current user.
  FStrautilsResponse<void> signOut();

  /// Gets the currently authenticated user, if any.
  Future<User?> getCurrentUser();

  /// Stream of user authentication status.
  Stream<User?> get userChanges;

  FStrautilsResponse<void> updateProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  });

  /// Uploads a profile avatar and returns its public URL.
  FStrautilsResponse<String> uploadAvatar({
    required String userId,
    required Uint8List fileBytes,
    required String fileName,
    String? mimeType,
  });

  /// Deletes the currently authenticated user account.
  FStrautilsResponse<void> deleteAccount();
}
