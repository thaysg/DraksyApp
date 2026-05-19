import 'package:strawti_utils/strawti_utils.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for Google Sign In.
class SignInWithGoogle {
  /// Creates a new [SignInWithGoogle] use case.
  SignInWithGoogle(this._repository);
  final AuthRepository _repository;

  /// Executes the sign in operation.
  FStrautilsResponse<User> call() async => _repository.signInWithGoogle();
}
