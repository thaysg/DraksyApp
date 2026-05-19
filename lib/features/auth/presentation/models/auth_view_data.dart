import 'package:equatable/equatable.dart';

import '../providers/auth_providers.dart';

/// UI-ready data for the Auth screen.
class AuthViewData extends Equatable {
  const AuthViewData({
    required this.authType,
    required this.isLoading,
    required this.emailConfirmationSent,
  });

  final AuthType authType;
  final bool isLoading;

  /// True after a successful signup call — Supabase requires e-mail
  /// confirmation before the session is created. The UI should show a
  /// "check your inbox" state instead of the form.
  final bool emailConfirmationSent;

  @override
  List<Object?> get props => [authType, isLoading, emailConfirmationSent];
}
