// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:techinng/features/auth/data/data_sources/auth_local_data_source.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/auth_result_model.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource; // Si tienes uno

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    
     required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthResult>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      print('Repository: Starting register request...');
      
      // Llamar al data source
      final authResultModel = await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
      );
      
      print('Repository: Register successful! User: ${authResultModel.user}');
      print('Repository: Tokens received: ${authResultModel.tokens != null}');
      
      // ✅ RETORNAR RIGHT EN ÉXITO
      return Right(authResultModel);
      
    } on ServerException catch (e) {
      print('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      print('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(e.message));
    } catch (e) {
      print('Repository: Unexpected error: $e');
      return Left(ServerFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      print('Repository: Starting login request...');
      
      final authResultModel = await remoteDataSource.login(
        emailOrUsername: emailOrUsername,
        password: password,
      );
      
      print('Repository: Login successful! User: ${authResultModel.user}');
      
      // ✅ RETORNAR RIGHT EN ÉXITO
      return Right(authResultModel);
      
    } on ServerException catch (e) {
      print('Repository: Login server exception: ${e.message}');
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      print('Repository: Login network exception: ${e.message}');
      return Left(NetworkFailure(e.message));
    } catch (e) {
      print('Repository: Login unexpected error: $e');
      return Left(ServerFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> signInWithGoogle() {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Google Sign In no implementado')));
  }

  @override
  Future<Either<Failure, String>> refreshToken(String refreshToken) {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Refresh token no implementado')));
  }

  @override
  Future<Either<Failure, User>> getProfile() {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Get profile no implementado')));
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() {
    // Implementación básica - retorna null si no hay usuario cacheado
    print('Repository: Getting current user from cache...');
    
    // TODO: Aquí deberías obtener el usuario del storage local
    // Por ahora retornamos null (no autenticado)
    return Future.value(Right(null));
  }

  @override
  Future<Either<Failure, bool>> validateToken() {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Validate token no implementado')));
  }

  @override
  Future<Either<Failure, void>> logout() {
    // Implementación básica - limpia datos locales
    print('Repository: Logging out...');
    
    // TODO: Limpiar tokens del storage local
    // TODO: Llamar endpoint de logout si es necesario
    
    return Future.value(Right(null));
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String token) {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Verify email no implementado')));
  }

  @override
  Future<Either<Failure, void>> resendVerification() {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Resend verification no implementado')));
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    // TODO: implementar cuando sea necesario
    return Future.value(Left(ServerFailure('Change password no implementado')));
  }

  @override
  Future<bool> isAuthenticated() {
    // Implementación básica - verificar si hay token guardado
    print('Repository: Checking if user is authenticated...');
    
    // TODO: Verificar si hay token válido en storage local
    // Por ahora retornamos false
    return Future.value(false);
  }

  @override
  Future<void> clearAuthData() {
    // Implementación básica - limpiar todos los datos de auth
    print('Repository: Clearing auth data...');
    
    // TODO: Limpiar tokens, usuario, etc. del storage local
    
    return Future.value();
  }
}