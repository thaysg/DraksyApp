import 'package:strawti_utils/strawti_utils.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing in with email and password.
class SignInWithEmail {
  /// Creates a new [SignInWithEmail] use case.
  SignInWithEmail(this._repository);
  final AuthRepository _repository;

  /// Executes the sign in operation.
  FStrautilsResponse<User> call(String email, String password) async =>
      _repository.signInWithEmailAndPassword(email, password);
}
