import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String isLoggedIn = 'isLoggedIn';

  static Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedIn) ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedIn, value);
  }
}
