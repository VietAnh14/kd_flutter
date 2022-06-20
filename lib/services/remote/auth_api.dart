import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/model/register_response.dart';
import 'package:flutter_kd/utils/network_utils.dart';
import 'package:flutter_kd/utils/string_ext.dart';

import 'model/token_response.dart';

class AuthApi {
  final dio = Dio();

  AuthApi() {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.options.baseUrl = ApiConst.baseUrl;
  }

  Options getFormUrlOptions() => Options(contentType: Headers.formUrlEncodedContentType);

  Future<Token> login(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };
      final result = await dio.post("api/auth/login", data: data, options: getFormUrlOptions());
      return Token.fromJson(result.data);
    } on DioError catch (e) {
      final err = e.toNetworkError((response) {
        final json = response.asJson();
        final message = json == null ? null : json['message'];
        return message;
      });

      throw err;
    }
  }

  Future<RegisterResponse> signUp(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };

      final result = await dio.post("api/register", data: data, options: getFormUrlOptions());
      return RegisterResponse.fromJson(result.data);
    } on DioError catch (e) {
      throw e.toNetworkError(null);
    }
  }
}