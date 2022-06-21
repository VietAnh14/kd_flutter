import 'package:dio/dio.dart';

import '../services/remote/api_const.dart';
import '../services/remote/api_exception.dart';

extension DioEx on DioError {

  NetworkError toNetworkError(String Function(String? response)? messageExtractor) {
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
    } else if (type == DioErrorType.other) {
      return UnknownNetworkException();
    } else {
      return UnreachableException();
    }
  }
}