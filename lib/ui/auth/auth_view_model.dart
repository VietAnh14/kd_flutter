import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';
import 'package:flutter_kd/ui/auth/login_event.dart';
import 'package:flutter_kd/utils/exception.dart';

import '../../services/preferences.dart';
import 'dart:async';

class AuthViewModel extends ChangeNotifier {
  final AuthApi authApi;
  final Preferences prefs;

  String _email = "";
  String _password = "";
  bool isValid = false;

  final _errorStream = StreamController<dynamic>();
  Stream<dynamic> get error => _errorStream.stream;
  final _loadingStream = StreamController<bool>();
  Stream<bool> get loading => _loadingStream.stream;
  final _eventStream = StreamController<AuthEvent>();
  Stream<AuthEvent> get event => _eventStream.stream;

  AuthViewModel(this.authApi, this.prefs);

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
      final tokenData = await authApi.login(_email, _password);
      final token = tokenData.token;
      if (token.isEmpty == false) {
        prefs.saveToken(token);
      }
      setLoading(false);
      _eventStream.add(LoginSuccess());
    } catch (e) {
      setLoading(false);
      sendError(e);
    }
  }

  void signup() async {
    try {
      setLoading(true);
      final authResponse = await authApi.signUp(_email, _password);
      if (authResponse.success != true) {
        throw IllegalStateException();
      }
      _eventStream.add(SignUpSuccess());
      setLoading(false);
    } catch (e) {
      setLoading(false);
      _eventStream.add(AuthCallFail());
    }
  }

  void sendError(dynamic exception) {
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