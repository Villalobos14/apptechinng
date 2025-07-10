// lib/features/auth/data/dtos/auth_response_dtos.dart

import '../../domain/entities/user.dart';
import '../../domain/entities/auth_result.dart';

class AuthResponseDto {
  final UserDto user;
  final TokensDto? tokens; // ← CAMBIO: Usar TokensDto en lugar de campos directos
  final String? accessToken; // ← MANTENER para compatibilidad
  final String? refreshToken; // ← MANTENER para compatibilidad
  final String message;

  const AuthResponseDto({
    required this.user,
    this.tokens,
    this.accessToken,
    this.refreshToken,
    required this.message,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    // Verificar si tokens vienen como objeto o como campos directos
    TokensDto? tokens;
    String? accessToken;
    String? refreshToken;

    if (json['tokens'] != null) {
      // Tokens como objeto (estructura nueva)
      tokens = TokensDto.fromJson(json['tokens']);
      accessToken = tokens.accessToken;
      refreshToken = tokens.refreshToken;
    } else {
      // Tokens como campos directos (tu estructura actual)
      accessToken = json['accessToken'];
      refreshToken = json['refreshToken'];
      if (accessToken != null && refreshToken != null) {
        tokens = TokensDto(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }
    }

    return AuthResponseDto(
      user: UserDto.fromJson(json['user']),
      tokens: tokens,
      accessToken: accessToken,
      refreshToken: refreshToken,
      message: json['message'] ?? '',
    );
  }

  // Convert to domain entity
  AuthResult toEntity() {
    return AuthResult(
      user: user.toEntity(),
      tokens: tokens?.toEntity(),
      accessToken: accessToken,
      refreshToken: refreshToken,
      message: message,
    );
  }
}

class TokensDto {
  final String accessToken;
  final String refreshToken;

  const TokensDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokensDto.fromJson(Map<String, dynamic> json) {
    return TokensDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  // Convert to domain entity
  Tokens toEntity() {
    return Tokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

class UserDto {
  final String id;
  final String username;
  final String email;
  final bool isVerified;
  final String? lastLoginAt;
  final String? createdAt; // ← CAMBIO: Puede ser null
  final String? updatedAt; // ← AGREGADO

  const UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      lastLoginAt: json['lastLoginAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'isVerified': isVerified,
      'lastLoginAt': lastLoginAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      isVerified: isVerified,
      lastLoginAt: lastLoginAt != null 
          ? DateTime.parse(lastLoginAt!) 
          : null,
      createdAt: createdAt != null 
          ? DateTime.parse(createdAt!) 
          : null,
      updatedAt: updatedAt != null 
          ? DateTime.parse(updatedAt!) 
          : null,
    );
  }
}

class RefreshTokenResponseDto {
  final String accessToken;
  final bool success;

  const RefreshTokenResponseDto({
    required this.accessToken,
    required this.success,
  });

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseDto(
      accessToken: json['accessToken'] as String,
      success: json['success'] as bool? ?? false,
    );
  }
}

class ValidateTokenResponseDto {
  final bool valid;
  final UserDto? user;

  const ValidateTokenResponseDto({
    required this.valid,
    this.user,
  });

  factory ValidateTokenResponseDto.fromJson(Map<String, dynamic> json) {
    return ValidateTokenResponseDto(
      valid: json['valid'] as bool? ?? false,
      user: json['user'] != null ? UserDto.fromJson(json['user']) : null,
    );
  }
}

class ProfileResponseDto {
  final UserDto user;

  const ProfileResponseDto({
    required this.user,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return ProfileResponseDto(
      user: UserDto.fromJson(json['user']),
    );
  }
}

class SimpleResponseDto {
  final bool success;
  final String message;

  const SimpleResponseDto({
    required this.success,
    required this.message,
  });

  factory SimpleResponseDto.fromJson(Map<String, dynamic> json) {
    return SimpleResponseDto(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }
}