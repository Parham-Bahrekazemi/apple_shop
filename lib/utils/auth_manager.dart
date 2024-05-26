import 'package:apple_shop/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _sharedPreferences = locator.get();

  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);

  //THIS METHOD SAVE THE TOKEN
  static void saveToken(String token) {
    _sharedPreferences.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  //THIS METHOD SAVE THE USER ID
  static void saveUserId(String userID) {
    _sharedPreferences.setString('user_id', userID);
  }

  //THIS METHOD READ USER ID
  static String readUserId() {
    return _sharedPreferences.getString('user_id') ?? '';
  }

  //THIS METHOD READ TOKEN
  static String readAuth() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  //THIS METHOD LOGOUT THE USER
  static void logOut() {
    _sharedPreferences.clear();
    authChangeNotifier.value = null;
  }

  //IF USER LOGIN IN APP THIS METHOD RETURN TRUE ELSE FALSE
  static bool isLogin() {
    String token = readAuth();
    return token.isNotEmpty; //true
  }
}
