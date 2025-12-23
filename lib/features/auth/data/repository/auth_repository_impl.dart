import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';
import 'package:pocket_pantry_frontend/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/login_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/register_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SafeApiCall safeApiCall;
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.safeApiCall, this.authRemoteDatasource);

  @override
  Future<Either<Failure, RegisterUserEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await safeApiCall.execute(
      () => authRemoteDatasource.registerUser(
        name: name,
        email: email,
        password: password,
      ),
    );

    return result.map((response) => response.toEntity());
  }

  @override
  Future<Either<Failure, LoginUserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    final result = await safeApiCall.execute(
      () => authRemoteDatasource.loginUser(email: email, password: password),
    );

    return result.map((response) => response.toEntity());
  }
}
