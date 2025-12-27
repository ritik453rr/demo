import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  AppStorage._(); // prevent instance creation

  static SharedPreferences? _prefs;

  static const String _keyIsLoggedIn = 'is_logged_in';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> setLoginStatus({required bool status}) async {
    await _prefs?.setBool(_keyIsLoggedIn, status);
  }

  static bool getLoginStatus() {
    return _prefs?.getBool(_keyIsLoggedIn) ?? false;
  }
}
