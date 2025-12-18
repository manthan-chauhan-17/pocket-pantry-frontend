import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/register_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repository;

  AuthUsecase(this.repository);

  Future<Either<Failure, RegisterUserEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return repository.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }
}
