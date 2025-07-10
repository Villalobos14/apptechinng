// lib/features/auth/domain/entities/user.dart

class User {
  final String id;
  final String username;
  final String email;
  final bool isVerified;
  final DateTime? lastLoginAt; // ← AGREGADO
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified,
    this.lastLoginAt, // ← AGREGADO
    this.createdAt,
    this.updatedAt,
  });
}