// PASO 3: AuthState con mejor manejo de nulos
// lib/features/auth/presentation/states/auth_state.dart

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final bool isRegistrationSuccess;
  final String? errorMessage;
  final dynamic user;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.isRegistrationSuccess = false,
    this.errorMessage,
    this.user,
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      isAuthenticated: false,
      isRegistrationSuccess: false,
      errorMessage: null,
      user: null,
    );
  }

  factory AuthState.loading() {
    return const AuthState(
      isLoading: true,
      isAuthenticated: false,
      isRegistrationSuccess: false,
      errorMessage: null,
      user: null,
    );
  }

  factory AuthState.authenticated(dynamic user) {
    return AuthState(
      isLoading: false,
      isAuthenticated: true,
      isRegistrationSuccess: false,
      errorMessage: null,
      user: user,
    );
  }

  factory AuthState.unauthenticated() {
    return const AuthState(
      isLoading: false,
      isAuthenticated: false,
      isRegistrationSuccess: false,
      errorMessage: null,
      user: null,
    );
  }

  factory AuthState.registrationSuccess(dynamic user) {
    return AuthState(
      isLoading: false,
      isAuthenticated: false,
      isRegistrationSuccess: true,
      errorMessage: null,
      user: user,
    );
  }

  factory AuthState.error(String message) {
    return AuthState(
      isLoading: false,
      isAuthenticated: false,
      isRegistrationSuccess: false,
      errorMessage: message,
      user: null,
    );
  }

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    bool? isRegistrationSuccess,
    String? errorMessage,
    dynamic user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isRegistrationSuccess: isRegistrationSuccess ?? this.isRegistrationSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isAuthenticated: $isAuthenticated, isRegistrationSuccess: $isRegistrationSuccess, hasError: $hasError, errorMessage: $errorMessage)';
  }
}