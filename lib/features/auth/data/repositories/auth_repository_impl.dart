import 'dart:typed_data';

import 'package:strawti_utils/strawti_utils.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/local/local_data_base.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of [AuthRepository] using [StrautilsTryThis].
class AuthRepositoryImpl extends StrautilsTryThis implements AuthRepository {
  /// Creates a new [AuthRepositoryImpl] instance.
  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDb,
    this._storageService,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final LocalDataBase _localDb;
  final StorageService _storageService;

  // ── Shared onCatch ─────────────────────────────────────────────────────────
  //
  // All datasource methods now throw typed [AppException] subclasses.
  // This handler catches any [AppException] and forwards its message
  // to [StrautilsResponse.error].

  StrautilsResponse<T> _onCatch<T>(Object error) {
    if (error is AppException) {
      return StrautilsResponse.error(error.message, error: error);
    }
    return StrautilsResponse.error(error.toString(), error: error);
  }

  // ── Methods ────────────────────────────────────────────────────────────────

  @override
  FStrautilsResponse<User> signInWithGoogle() async => tryThis(
        () async {
          final userModel = await _remoteDataSource.signInWithGoogle();
          return StrautilsResponse.success(userModel);
        },
        onCatch: _onCatch,
        tryAgain: signInWithGoogle,
        action: 'sign in with Google',
      );

  @override
  FStrautilsResponse<User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async =>
      tryThis(
        () async {
          final userModel = await _remoteDataSource.signInWithEmailAndPassword(
            email,
            password,
          );
          return StrautilsResponse.success(userModel);
        },
        onCatch: _onCatch,
        tryAgain: () => signInWithEmailAndPassword(email, password),
        action: 'sign in with email',
      );

  @override
  FStrautilsResponse<User> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async =>
      tryThis(
        () async {
          final userModel = await _remoteDataSource.signUpWithEmailAndPassword(
            email,
            password,
            displayName,
          );
          return StrautilsResponse.success(userModel);
        },
        onCatch: _onCatch,
        tryAgain: () =>
            signUpWithEmailAndPassword(email, password, displayName),
        action: 'sign up with email',
      );

  @override
  FStrautilsResponse<void> signOut() async => tryThis(
        () async {
          await _remoteDataSource.signOut();
          await _localDb.clearUserData();
          return StrautilsResponse.success(null);
        },
        onCatch: _onCatch,
        action: 'sign out',
      );

  @override
  Future<User?> getCurrentUser() async => _remoteDataSource.getCurrentUser();

  @override
  Stream<User?> get userChanges => _remoteDataSource.userChanges;

  @override
  FStrautilsResponse<void> updateProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  }) async =>
      tryThis(
        () async {
          await _remoteDataSource.updateProfile(
            displayName: displayName,
            photoUrl: photoUrl,
            bio: bio,
          );
          return StrautilsResponse.success(null);
        },
        onCatch: _onCatch,
        tryAgain: () => updateProfile(
          displayName: displayName,
          photoUrl: photoUrl,
          bio: bio,
        ),
        action: 'update profile',
      );

  @override
  FStrautilsResponse<String> uploadAvatar({
    required String userId,
    required Uint8List fileBytes,
    required String fileName,
    String? mimeType,
  }) async =>
      tryThis(
        () async {
          final url = await _storageService.uploadAvatar(
            userId: userId,
            fileBytes: fileBytes,
            fileName: fileName,
            mimeType: mimeType,
          );
          return StrautilsResponse.success(url);
        },
        onCatch: _onCatch,
        action: 'upload avatar',
      );

  @override
  FStrautilsResponse<void> deleteAccount() async => tryThis(
        () async {
          await _remoteDataSource.deleteAccount();
          await _localDb.clearUserData();
          return StrautilsResponse.success(null);
        },
        onCatch: _onCatch,
        action: 'delete account',
      );
}
