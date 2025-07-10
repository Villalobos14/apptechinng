// lib/features/auth/data/models/user_model.dart

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String username,
    required String email,
    required bool isVerified,
    DateTime? lastLoginAt, // ← AGREGADO
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          username: username,
          email: email,
          isVerified: isVerified,
          lastLoginAt: lastLoginAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      print('UserModel: Parsing JSON: $json');
      
      return UserModel(
        id: json['id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        isVerified: json['isVerified'] as bool? ?? false,
        lastLoginAt: json['lastLoginAt'] != null 
            ? DateTime.parse(json['lastLoginAt'] as String)
            : null,
        createdAt: json['createdAt'] != null 
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null 
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
      );
    } catch (e) {
      print('UserModel: Parsing error: $e');
      throw Exception('Error parsing user: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'isVerified': isVerified,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}