import 'dart:async';

import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

/// Implementation of [AuthRemoteDataSource] using Mock data for portfolio.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  final _userController = StreamController<UserModel?>.broadcast();
  UserModel? _currentUser;

  static final _mockUser = UserModel(
    id: 'mock-user-123',
    email: 'portfolio@example.com',
    displayName: 'Portfolio User',
    createdAt: DateTime.now(),
  );

  @override
  Future<UserModel> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = _mockUser;
    _userController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = _mockUser;
    _userController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = UserModel(
      id: 'mock-user-${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: displayName,
      createdAt: DateTime.now(),
    );
    _userController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _userController.add(null);
  }

  @override
  Future<UserModel?> getCurrentUser() async => _currentUser;

  @override
  Stream<UserModel?> get userChanges => _userController.stream;

  @override
  Future<void> updateProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  }) async {
    if (_currentUser != null) {
      _currentUser = UserModel(
        id: _currentUser!.id,
        email: _currentUser!.email,
        displayName:
            displayName.isNotEmpty ? displayName : _currentUser!.displayName,
        photoURL: photoUrl.isNotEmpty ? photoUrl : _currentUser!.photoURL,
        bio: bio.isNotEmpty ? bio : _currentUser!.bio,
        createdAt: _currentUser!.createdAt,
      );
      _userController.add(_currentUser);
    }
  }

  @override
  Future<void> deleteAccount() async {
    await signOut();
  }
}
