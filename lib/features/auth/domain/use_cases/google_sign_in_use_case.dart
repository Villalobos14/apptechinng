// lib/features/auth/domain/use_cases/google_sign_in_use_case.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository repository;

  const GoogleSignInUseCase(this.repository);

  Future<Either<Failure, AuthResult>> call() async {
    try{
          print("Paso por use case");
    return await repository.signInWithGoogle();
    }catch(e){
      print("======ERROR==========");
      print(e);
      throw e;
    }
    
  }
}