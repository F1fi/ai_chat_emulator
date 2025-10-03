part of 'auth_cubit.dart';

class AuthState {
  const AuthState({
    this.isInitialized = false,
    this.isLoading = false,
    this.login,
  });

  final bool isInitialized;
  final bool isLoading;
  final String? login;

  bool get isAuthorized => login != null;

  AuthState copyWith({
    bool? isInitialized,
    bool? isLoading,
    String? Function()? login,
  }) {
    return AuthState(
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      login: login != null ? login.call() : this.login,
    );
  }
}
