// lib/features/auth/data/data_sources/auth_local_data_source.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  
  Future<void> clearAll();
  
  Future<bool> hasValidTokens();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  
  const AuthLocalDataSourceImpl({required this.secureStorage});
  
  // Keys for secure storage
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      print('LocalDataSource: Saving tokens...');
      
      await Future.wait([
        secureStorage.write(key: _accessTokenKey, value: accessToken),
        secureStorage.write(key: _refreshTokenKey, value: refreshToken),
      ]);
      
      print('LocalDataSource: Tokens saved successfully');
    } catch (e) {
      print('LocalDataSource: Error saving tokens: $e');
      throw CacheException('Error saving tokens: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      final token = await secureStorage.read(key: _accessTokenKey);
      print('LocalDataSource: Access token retrieved: ${token != null}');
      return token;
    } catch (e) {
      print('LocalDataSource: Error getting access token: $e');
      return null; // No lanzar error, solo retornar null
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final token = await secureStorage.read(key: _refreshTokenKey);
      print('LocalDataSource: Refresh token retrieved: ${token != null}');
      return token;
    } catch (e) {
      print('LocalDataSource: Error getting refresh token: $e');
      return null;
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      print('LocalDataSource: Saving user data...');
      
      final userJson = jsonEncode(user.toJson());
      await secureStorage.write(key: _userDataKey, value: userJson);
      
      print('LocalDataSource: User data saved successfully');
    } catch (e) {
      print('LocalDataSource: Error saving user data: $e');
      throw CacheException('Error saving user data: $e');
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userData = await secureStorage.read(key: _userDataKey);
      print('LocalDataSource: User data retrieved: ${userData != null}');
      
      if (userData == null) return null;
      
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      print('LocalDataSource: Error getting user data: $e');
      return null;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      print('LocalDataSource: Clearing all auth data...');
      
      await Future.wait([
        secureStorage.delete(key: _accessTokenKey),
        secureStorage.delete(key: _refreshTokenKey),
        secureStorage.delete(key: _userDataKey),
      ]);
      
      print('LocalDataSource: All auth data cleared');
    } catch (e) {
      print('LocalDataSource: Error clearing data: $e');
      throw CacheException('Error clearing auth data: $e');
    }
  }

  @override
  Future<bool> hasValidTokens() async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      
      final hasTokens = accessToken != null && 
                       accessToken.isNotEmpty &&
                       refreshToken != null && 
                       refreshToken.isNotEmpty;
      
      print('LocalDataSource: Has valid tokens: $hasTokens');
      return hasTokens;
    } catch (e) {
      print('LocalDataSource: Error checking tokens: $e');
      return false;
    }
  }
}