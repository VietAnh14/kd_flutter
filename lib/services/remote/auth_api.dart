import 'package:dio/dio.dart';
import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';

import 'model/token_response.dart';

class AuthApi {
  final dio = Dio();

  AuthApi() {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.options.baseUrl = baseUrl;
  }

  Future<Token?> login(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };
      final options = Options(contentType: Headers.formUrlEncodedContentType);
      final result = await dio.post("api/auth/login", data: data, options: options);
      return Token.fromJson(result.data);
    } on DioError catch (e) {
      final response = e.response;
      if (response == null) {
        throw ApiException.unknown();
      }
      final code = response.statusCode ?? ApiException.unknownCode;
      final data = response.data as Map<String, dynamic>;
      final apiEx = ApiException(
        code: code,
        message: data['error'],
        body: e.response?.data.toString()
      );
      throw apiEx;
    }
  }
}