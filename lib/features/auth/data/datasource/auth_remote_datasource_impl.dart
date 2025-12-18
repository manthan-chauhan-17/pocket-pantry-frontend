import 'dart:convert';

import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:pocket_pantry_frontend/features/auth/data/models/register_user_model.dart';

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final ApiClient apiClient;

  AuthRemoteDatasourceImpl(this.apiClient);

  @override
  Future<RegisterUserModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final body = {'name': name, 'email': email, 'password': password};
    final response = await apiClient.postFormDynamic('auth/register', body);
    return RegisterUserModel.fromJson(jsonDecode(response));
  }
}
