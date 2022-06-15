import 'package:flutter_kd/utils/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences? prefs;
  static const tokenKey = "token_key";

  Preferences(this.prefs);

  void saveToken(String? token) async {
    await prefs?.setString(tokenKey, token.orEmpty());
  }

  String? getToken() => prefs?.getString(tokenKey);
}