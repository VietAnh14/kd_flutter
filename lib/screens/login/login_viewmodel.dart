import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';

import '../../services/preferences.dart';
import 'dart:async';

class LoginViewModel extends ChangeNotifier {
  final AuthApi authApi;
  final Preferences prefs;

  String _email = "";
  String _passWord = "";
  bool isValid = false;
  bool isLoading = false;
  final loadingStream = Stream.value(false);
  StreamController<String> messageEvent = StreamController<String>();

  LoginViewModel(this.authApi, this.prefs);

  void onEmailChange(String email) {
    _email = email;
    checkValid();
  }

  void onPaswordChange(String password) {
    _passWord = password;
    checkValid();
  }

  void checkValid() {
    final lenValid = _email.length > 6 && _passWord.length > 6;
    isValid = lenValid;
    notifyListeners();
  }

  void login() async {
    isLoading = true;
    if (!isValid) {
      return;
    }

    final tokenData = await authApi.login(_email, _passWord);
    final token = tokenData?.token;
    if (token?.isEmpty == true) {
      return;
    }

    prefs.saveToken(token!);
    isLoading = false;
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void dispose() {
    messageEvent.close();
  }
}