// lib/features/auth/data/data_sources/auth_remote_data_source.dart

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/auth_result_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResultModel> register({
    required String username,
    required String email,
    required String password,
  });
  
  Future<AuthResultModel> login({
    required String emailOrUsername,
    required String password,
  });
  
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;


  
  const AuthRemoteDataSourceImpl({required this.dio,
 
  });

  @override
  Future<AuthResultModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      print('DataSource: Making register request...');
      
      final response = await dio.post(
        '/auth/register', // Tu endpoint
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
      
      print('DataSource: Response status: ${response.statusCode}');
      print('DataSource: Response data: ${response.data}');
      
      // ✅ VERIFICAR STATUS CODE
      if (response.statusCode == 201 || response.statusCode == 200) {
        final authResult = AuthResultModel.fromJson(response.data);
        print('DataSource: AuthResult created successfully');
        return authResult;
      } else {
        print('DataSource: Unexpected status code: ${response.statusCode}');
        throw ServerException('Error del servidor: ${response.statusCode}');
      }
      
    } on DioException catch (e) {
      print('DataSource: Dio exception: ${e.message}');
      
      if (e.response != null) {
        final errorMessage = e.response?.data?['message'] ?? 
                           e.response?.data?['error'] ?? 
                           'Error del servidor';
        throw ServerException(errorMessage);
      } else {
        throw NetworkException('Error de conexión');
      }
    } catch (e) {
      print('DataSource: Unexpected error: $e');
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<AuthResultModel> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      print('DataSource: Making login request...');
      
      final response = await dio.post(
        '/auth/login', // Tu endpoint
        data: {
          'emailOrUsername': emailOrUsername,
          'password': password,
        },
      );
      
      print('DataSource: Login response status: ${response.statusCode}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResult = AuthResultModel.fromJson(response.data);
        return authResult;
      } else {
        throw ServerException('Error del servidor: ${response.statusCode}');
      }
      
    } on DioException catch (e) {
      print('DataSource: Login dio exception: ${e.message}');
      
      if (e.response != null) {
        final errorMessage = e.response?.data?['message'] ?? 
                           'Credenciales incorrectas';
        throw ServerException(errorMessage);
      } else {
        throw NetworkException('Error de conexión');
      }
    } catch (e) {
      print('DataSource: Login unexpected error: $e');
      throw ServerException('Error inesperado: $e');
    }
  }
  
}