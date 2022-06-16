import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';

import '../../services/preferences.dart';
import 'dart:async';

class LoginViewModel extends ChangeNotifier {
  final AuthApi authApi;
  final Preferences prefs;

  String _email = "";
  String _password = "";
  bool isValid = false;
  final _errorStream = StreamController<Exception>();
  Stream<Exception> get error => _errorStream.stream;
  final _loadingStream = StreamController<bool>();
  Stream<bool> get loading => _loadingStream.stream;

  LoginViewModel(this.authApi, this.prefs);

  void onEmailChange(String email) {
    _email = email;
    checkValid();
  }

  void onPaswordChange(String password) {
    _password = password;
    checkValid();
  }

  void checkValid() {
    final lenValid = _email.length > 6 && _password.length > 6;
    isValid = lenValid;
    notifyListeners();
  }

  void login() async {
    try {
      setLoading(true);
      prefs.saveToken(null);
      final tokenData = await authApi.login(_email, _password);
      final token = tokenData?.token;
      if (token?.isEmpty == false) {
        prefs.saveToken(token!);
      }
    } on Exception catch(e) {
      sendError(e);
    } finally {
      setLoading(false);
    }
  }

  void sendError(Exception exception) {
    _errorStream.add(exception);
  }

  void setLoading(bool loading) {
    _loadingStream.add(loading);
  }

  void dispose() {
    _loadingStream.close();
    _errorStream.close();
  }
}