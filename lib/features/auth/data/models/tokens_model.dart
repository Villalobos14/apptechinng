// lib/features/auth/data/models/tokens_model.dart

import '../../domain/entities/auth_result.dart';

class TokensModel extends Tokens {
  const TokensModel({
    required String accessToken,
    required String refreshToken,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    try {
      print('TokensModel: Parsing JSON: $json');
      
      return TokensModel(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );
    } catch (e) {
      print('TokensModel: Parsing error: $e');
      throw Exception('Error parsing tokens: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}