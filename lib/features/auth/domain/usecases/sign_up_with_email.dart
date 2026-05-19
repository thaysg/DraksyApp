import 'package:strawti_utils/strawti_utils.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing up with email and password.
class SignUpWithEmail {
  /// Creates a new [SignUpWithEmail] use case.
  SignUpWithEmail(this._repository);
  final AuthRepository _repository;

  /// Executes the sign up operation.
  FStrautilsResponse<User> call(
    String email,
    String password,
    String displayName,
  ) async =>
      _repository.signUpWithEmailAndPassword(email, password, displayName);
}
