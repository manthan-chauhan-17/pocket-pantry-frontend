import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String isLoggedIn = 'isLoggedIn';
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String userEmail = 'userEmail';

  static Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedIn) ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedIn, value);
  }

  static Future<void> saveLoginDetails(
    String token,
    String userId,
    String userName,
    String userEmail,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, token);
    await prefs.setString(userId, userId);
    await prefs.setString(userName, userName);
    await prefs.setString(userEmail, userEmail);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId) ?? '';
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail) ?? '';
  }
}
