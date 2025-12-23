import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/login_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/register_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterUserEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, LoginUserEntity>> loginUser({
    required String email,
    required String password,
  });
}
