// lib/features/auth/presentation/view_models/auth_view_model.dart

import 'package:flutter/foundation.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/google_sign_in_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';
import '../states/auth_state.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthState _state = AuthState.initial();
  AuthState get state => _state;

  AuthViewModel({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _googleSignInUseCase = googleSignInUseCase,
        _logoutUseCase = logoutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase;

  /// Initialize the auth state by checking if user is already authenticated
  Future<void> initialize() async {
    print('ViewModel: Initializing auth state...');
    _setState(AuthState.loading());
    
    try {
      final result = await _getCurrentUserUseCase.call();
      result.fold(
        (failure) {
          print('ViewModel: Initialize failure: ${failure.message}');
          _setState(AuthState.unauthenticated());
        },
        (user) {
          print('ViewModel: Initialize success - User authenticated: ${user?.username}');
          if (user != null) {
            _setState(AuthState.authenticated(user));
          } else {
            _setState(AuthState.unauthenticated());
          }
        },
      );
    } catch (e) {
      print('ViewModel: Initialize error: $e');
      _setState(AuthState.unauthenticated());
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    print('ViewModel: Starting register with email: $email, username: $username');
    _setState(AuthState.loading());
    
    try {
      final result = await _registerUseCase.call(
        RegisterParams(
          username: username,
          email: email,
          password: password,
        ),
      );
      
      result.fold(
        (failure) {
          print('ViewModel: Register failure: $failure');
          final errorMessage = failure.message.isNotEmpty 
              ? failure.message 
              : 'Error desconocido de registro';
          _setState(AuthState.error(errorMessage));
        },
        (authResult) {
          print('ViewModel: Register success!');
          print('ViewModel: User: ${authResult.user.username}');
          print('ViewModel: Message: ${authResult.message}');
          
          // ✅ USAR REGISTRATION SUCCESS
          _setState(AuthState.registrationSuccess(authResult.user));
        },
      );
    } catch (e) {
      print('ViewModel: Register unexpected error: $e');
      _setState(AuthState.error('Error inesperado: ${e.toString()}'));
    }
  }

  Future<void> login({
    required String emailOrUsername,
    required String password,
  }) async {
    print('ViewModel: Starting login with email: $emailOrUsername');
    _setState(AuthState.loading());
    
    try {
      final result = await _loginUseCase.call(
        emailOrUsername: emailOrUsername,
        password: password,
      );
      
      result.fold(
        (failure) {
          print('ViewModel: Login failure: $failure');
          final errorMessage = failure.message.isNotEmpty 
              ? failure.message 
              : 'Credenciales incorrectas';
          _setState(AuthState.error(errorMessage));
        },
        (authResult) {
          print('ViewModel: Login success!');
          print('ViewModel: User: ${authResult.user.username}');
          
          // ✅ USAR AUTHENTICATED
          _setState(AuthState.authenticated(authResult.user));
        },
      );
    } catch (e) {
      print('ViewModel: Login unexpected error: $e');
      _setState(AuthState.error('Error inesperado: ${e.toString()}'));
    }
  }

  Future<void> signInWithGoogle() async {
    print('ViewModel: Starting Google sign in...');
    _setState(AuthState.loading());
    
    try {
      final result = await _googleSignInUseCase.call();
      result.fold(
        (failure) {
          print('ViewModel: Google sign in failure: $failure');
          _setState(AuthState.error(failure.message.isNotEmpty ? failure.message : 'Error de Google Sign In'));
        },
        (authResult) {
          print('ViewModel: Google sign in success!');
          _setState(AuthState.authenticated(authResult.user));
        },
      );
    } catch (e) {
      print('ViewModel: Google sign in unexpected error: $e');
      _setState(AuthState.error('Error inesperado: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    print('ViewModel: Starting logout...');
    _setState(AuthState.loading());
    
    try {
      final result = await _logoutUseCase.call();
      result.fold(
        (failure) {
          print('ViewModel: Logout failure: $failure');
          _setState(AuthState.error(failure.message.isNotEmpty ? failure.message : 'Error de logout'));
        },
        (_) {
          print('ViewModel: Logout success!');
          _setState(AuthState.unauthenticated());
        },
      );
    } catch (e) {
      print('ViewModel: Logout unexpected error: $e');
      _setState(AuthState.error('Error inesperado: ${e.toString()}'));
    }
  }

  void clearAuthState() {
    print('ViewModel: Clearing auth state');
    _setState(AuthState.initial());
  }

  void clearError() {
    if (_state.hasError) {
      print('ViewModel: Clearing error state');
      _setState(AuthState.initial());
    }
  }

  void _setState(AuthState s) {
    print('ViewModel: State changed from ${_state.runtimeType} to ${s.runtimeType}');
    print('ViewModel: New state details: $s');
    _state = s;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}