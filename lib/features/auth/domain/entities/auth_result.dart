// lib/features/auth/domain/entities/auth_result.dart

import 'user.dart';

class AuthResult {
  final User user;
  final Tokens? tokens;
  final String? message;
  // ← OPCIÓN: También podrías agregar estos campos directos si tu API los maneja así
  final String? accessToken;
  final String? refreshToken;

  const AuthResult({
    required this.user,
    this.tokens,
    this.message,
    this.accessToken,
    this.refreshToken,
  });
}

class Tokens {
  final String accessToken;
  final String refreshToken;

  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });
}