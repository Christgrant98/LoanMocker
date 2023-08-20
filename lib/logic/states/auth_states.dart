import '../../data/models/user.dart';

enum AuthStatus {
  initial,
  loading,
  successLogin,
  sucessCreate,
  failureLogin,
  failureCreate
}

class AuthState {
  final User? user;
  final String? error;
  final AuthStatus authStatus;

  AuthState({
    required this.user,
    required this.error,
    required this.authStatus,
  });

  factory AuthState.initial() {
    return AuthState(
      user: null,
      error: null,
      authStatus: AuthStatus.initial,
    );
  }

  AuthState copyWith({
    User? user,
    String? error,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      error: error ?? this.error,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
