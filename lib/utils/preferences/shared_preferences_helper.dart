import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_transportation_driver/constants/preferences_constants.dart';
import 'package:university_transportation_driver/modules/models/login_model_web.dart';

class SharedPreferencesHelper {
  static Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(PreferencesConstants.kIsLoggedIn) ?? false;
  }

  static Future<bool> setIsLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(PreferencesConstants.kIsLoggedIn, value);
  }

  static Future<bool> clearIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(PreferencesConstants.kIsLoggedIn);
  }

  static Future<String> getApiToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PreferencesConstants.kApiToken) ?? '';
  }

  static Future<bool> setApiToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PreferencesConstants.kApiToken, value);
  }

  static Future<bool> clearApiToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(PreferencesConstants.kApiToken);
  }

  static Future<LoginModelWeb> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var account = prefs.getString(PreferencesConstants.kCurrentUser) ?? '';
    if (account != null && account.length > 0) {
      final Map parsed = json.decode(account);
      return LoginModelWeb.fromJson(parsed);
    }

    return null;
  }

  static Future<bool> setCurrentUser(LoginModelWeb value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(
        PreferencesConstants.kCurrentUser, json.encode(value));
  }

  static Future<bool> clearCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(PreferencesConstants.kCurrentUser);
  }

  static Future<bool> clearAllPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
