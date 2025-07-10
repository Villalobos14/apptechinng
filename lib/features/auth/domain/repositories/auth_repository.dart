// lib/features/auth/domain/repositories/auth_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../entities/auth_result.dart';

abstract class AuthRepository {
  /// Register a new user
  Future<Either<Failure, AuthResult>> register({
    required String username,
    required String email,
    required String password,
  });

  /// Login with email or username
  Future<Either<Failure, AuthResult>> login({
    required String emailOrUsername,
    required String password,
  });

  /// Sign in with Google
  Future<Either<Failure, AuthResult>> signInWithGoogle();

  /// Refresh access token
  Future<Either<Failure, String>> refreshToken(String refreshToken);

  /// Get current user profile
  Future<Either<Failure, User>> getProfile();

  /// Get cached current user (if available)
  Future<Either<Failure, User?>> getCurrentUser();

  /// Validate current token
  Future<Either<Failure, bool>> validateToken();

  /// Logout user
  Future<Either<Failure, void>> logout();

  /// Verify email with token
  Future<Either<Failure, void>> verifyEmail(String token);

  /// Resend verification email
  Future<Either<Failure, void>> resendVerification();

  /// Change password
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Check if user is authenticated (has valid token)
  Future<bool> isAuthenticated();

  /// Clear all auth data
  Future<void> clearAuthData();
}