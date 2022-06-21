import 'package:flutter_kd/utils/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;
  static const tokenKey = "token_key";

  Preferences();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveToken(String? token) async {
    await prefs.setString(tokenKey, token.orEmpty());
  }

  bool get isAuth => !getToken().isNullOrEmpty();

  String? getToken() => prefs.getString(tokenKey);
}