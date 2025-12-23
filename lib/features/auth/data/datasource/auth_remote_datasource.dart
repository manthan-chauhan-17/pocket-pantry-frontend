import 'package:pocket_pantry_frontend/features/auth/data/models/login_user_model.dart';
import 'package:pocket_pantry_frontend/features/auth/data/models/register_user_model.dart';

abstract class AuthRemoteDatasource {
  Future<RegisterUserModel> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<LoginUserModel> loginUser({
    required String email,
    required String password,
  });
}
