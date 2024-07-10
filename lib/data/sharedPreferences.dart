import 'dart:convert';

import 'package:learn_eng/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferences {
  //! Save user data to shared preferences
  static Future<void> saveUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString("kullanici", userJson);
  }

  //! Get user data from shared preferences
  static Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("kullanici");
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    UserModel userModel = UserModel.empty();
    return userModel;
  }

  static Future<void> saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", true);
  }
  static Future<bool> getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? login = prefs.getBool("login");
    if (login != null) {
      return login;
    }
    return false;
  }
}
