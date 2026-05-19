import '../models/user_model.dart';

/// Interface for remote authentication data source.
abstract class AuthRemoteDataSource {
  /// Signs in with Google and returns the user model.
  Future<UserModel> signInWithGoogle();

  /// Signs in with email and password.
  Future<UserModel> signInWithEmailAndPassword(String email, String password);

  /// Signs up with email and password.
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  );

  /// Signs out from the remote source.
  Future<void> signOut();

  /// Gets the currently authenticated user from remote source.
  Future<UserModel?> getCurrentUser();

  /// Stream of user changes.
  Stream<UserModel?> get userChanges;

  Future<void> updateProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  });

  /// Deletes the currently authenticated user.
  Future<void> deleteAccount();
}
