import 'package:dio/dio.dart';
import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';

class AuthInterceptor extends Interceptor {
  //TODO: Seem like not working
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (DioErrorType.response == err.type) {
      final responseData = err.response?.data;
      if (responseData != null && responseData is Map<String, dynamic>) {
        final message = responseData['error'];
        if (message == ApiConst.tokenExpiredMessage) {
          throw AuthorizationException();
        }
      }
    }
    handler.next(err);
  }
}