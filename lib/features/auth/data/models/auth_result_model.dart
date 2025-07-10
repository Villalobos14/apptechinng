// lib/features/auth/data/models/auth_result_model.dart

import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user.dart';
import 'user_model.dart';
import 'tokens_model.dart';

class AuthResultModel extends AuthResult {
  const AuthResultModel({
    required UserModel user,
    required TokensModel? tokens,
    String? message,
  }) : super(user: user, tokens: tokens, message: message);

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    try {
      print('AuthResultModel: Parsing JSON: $json');
      
      // Parsear usuario
      final userJson = json['user'];
      if (userJson == null) {
        throw Exception('User data not found in response');
      }
      final user = UserModel.fromJson(userJson);
      
      // Parsear tokens (opcional)
      TokensModel? tokens;
      final tokensJson = json['tokens'];
      if (tokensJson != null) {
        tokens = TokensModel.fromJson(tokensJson);
      }
      
      // Mensaje opcional
      final message = json['message'] as String?;
      
      print('AuthResultModel: Parsing successful');
      
      return AuthResultModel(
        user: user,
        tokens: tokens,
        message: message,
      );
    } catch (e) {
      print('AuthResultModel: Parsing error: $e');
      throw Exception('Error parsing auth result: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserModel).toJson(),
      'tokens': tokens != null ? (tokens as TokensModel).toJson() : null,
      'message': message,
    };
  }
}