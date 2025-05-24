import 'dart:developer';
import 'package:pocket_pantry_frontend/models/user_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/retorfit/injection.dart';

class Api {
  // Healthcheck
  static checkHealthApi() async {
    await restClient.healthcheck().then((value) {
      log('Healthcheck API response: $value', name: 'ApiService');
    }).catchError((error) {
      log('Error in healthcheck API: $error', name: 'ApiService');
    });
  }

  // Register User
  static Future<UserModel> registerUser(
      String name, String email, String password) async {
    Map<String, dynamic> body = {};
    body['name'] = name;
    body['email'] = email;
    body['password'] = password;

    log(body.toString(), name: "BODY");
    // var jsonBody = jsonEncode(body);
    try {
      UserModel result = await restClient.register(body);
      return result;
    } catch (e) {
      log(e.toString(), name: "Error in registering user");
      rethrow;
    }
  }

  static Future<UserModel> loginUser(String email, String password) async {
    Map<String, dynamic> body = {};
    body['email'] = email;
    body['password'] = password;

    try {
      UserModel result = await restClient.login(body);
      return result;
    } catch (e) {
      log(e.toString(), name: "Error in login user");
      rethrow;
    }
  }
}
