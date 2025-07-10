// lib/features/auth/domain/use_cases/login_use_case.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  Future<Either<Failure, AuthResult>> call({
    required String emailOrUsername,
    required String password,
  }) async {
    return await repository.login(
      emailOrUsername: emailOrUsername,
      password: password,
    );
  }
}

class LoginParams {
  const LoginParams({
    required this.emailOrUsername,
    required this.password,
  });
  final String emailOrUsername;
  final String password;

  
}