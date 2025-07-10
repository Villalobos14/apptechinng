// lib/features/auth/domain/use_cases/register_use_case.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  const RegisterUseCase(this.repository);

  /// Ahora recibe un solo RegisterParams
  Future<Either<Failure, AuthResult>> call(RegisterParams params) async {
    return await repository.register(
      username: params.username,
      email:    params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String username;
  final String email;
  final String password;

  const RegisterParams({
    required this.username,
    required this.email,
    required this.password,
  });
}
