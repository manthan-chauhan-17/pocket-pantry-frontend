import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static const String keyId = "user_id";
  static const String keyName = "user_name";
  static const String keyEmail = "user_email";
  static const String keyToken = "user_token";

  static Future<void> saveUserData(
      {required String id,
      required String name,
      required String email,
      required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyId, id);
    await prefs.setString(keyName, name);
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyToken, token);
  }

  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(keyId);
    String? name = prefs.getString(keyName);
    String? email = prefs.getString(keyEmail);
    String? token = prefs.getString(keyToken);

    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString(keyToken)!;

    return token;
  }
}
