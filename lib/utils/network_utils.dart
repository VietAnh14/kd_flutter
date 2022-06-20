import 'package:dio/dio.dart';

import '../services/remote/api_exception.dart';

extension DioEx on DioError {
  Exception toNetworkError(String Function(String? response)? messageExtractor) {
    if (type == DioErrorType.response) {
      if (response == null) {
        return ApiException.unknown();
      }

      final code = response?.statusCode ?? ApiException.unknownCode;
      String? message;
      try {
        message = messageExtractor?.call(response?.data);
      } catch (e) { }
      return ApiException(code: code, message: message);
    }

    return NetworkError();
  }
}