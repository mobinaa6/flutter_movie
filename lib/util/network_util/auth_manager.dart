import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/constants/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) {
    _sharedPref.setString(KEY_TOKEN_SHARED, token);
  }

  static void saveID(String id) {
    _sharedPref.setString(KEY_ID_SHARED, id);
  }

  static String getID() {
    return _sharedPref.getString(KEY_ID_SHARED) ?? '';
  }

  static String readAuth() {
    return _sharedPref.getString(KEY_TOKEN_SHARED) ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
  }

  static bool isLogIn() {
    String token = AuthManager.readAuth();
    return token.isEmpty;
  }
}
