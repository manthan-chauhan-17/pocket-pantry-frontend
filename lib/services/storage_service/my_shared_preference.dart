import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static const String keyId = "user_id";
  static const String keyName = "user_name";
  static const String keyEmail = "user_email";
  static const String keyToken = "user_token";
  static const String keyIsLoggedIn = "is_logged_in";

  static Future<void> saveUserData({
    required String id,
    required String name,
    required String email,
    required String token,
    required String isLoggedIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyId, id);
    await prefs.setString(keyName, name);
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyToken, token);
    await prefs.setString(keyIsLoggedIn, isLoggedIn);
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

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyIsLoggedIn) == "true";
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(keyId)!;
    return id;
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(keyName)!;
    return name;
  }

  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(keyEmail)!;
    return email;
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString(keyToken)!;

    return token;
  }
}
