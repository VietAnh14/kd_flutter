import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/services/remote/model/register_response.dart';
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
      final response = e.response;
      if (response == null) {
        throw ApiException.unknown();
      }
      final code = response.statusCode ?? ApiException.unknownCode;
      final data = (response.data as String).asJson();
      final message = data == null ? data!['message'] : null;
      final apiEx = ApiException(
        code: code,
        message: message,
        body: e.response?.data.toString()
      );
      throw apiEx;
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
      final response = e.response;
      if (response == null) {
        throw ApiException.unknown();
      }
      final code = response.statusCode ?? ApiException.unknownCode;
      final data = response.data.toString();
      final apiEx = ApiException(
          code: code,
          body: data
      );
      throw apiEx;
    }
  }
}