// lib/features/auth/domain/use_cases/get_current_user_use_case.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;
  
  const GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, User?>> call() async {
    try {
      // Verificar si el usuario está autenticado
      final isAuth = await repository.isAuthenticated();
      
      if (!isAuth) {
        return Left(CacheFailure('Usuario no autenticado'));
      }
      
      // Intentar obtener el usuario actual del cache/storage
      final result = await repository.getCurrentUser();
      
      return result.fold(
        (failure) => Left(failure),
        (user) => Right(user),
      );
    } catch (e) {
      return Left(CacheFailure('Error obteniendo usuario actual: $e'));
    }
  }
}