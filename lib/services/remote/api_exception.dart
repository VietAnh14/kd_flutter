import 'dart:io';

import 'package:flutter_kd/utils/exception.dart';

abstract class NetworkError implements IOException {
  factory NetworkError.unknown() => UnknownNetworkException();
  factory NetworkError.api(int code, String? message) => ApiException(code: code, message: message);
  factory NetworkError.unReachable() => UnreachableException();
  factory NetworkError.authorization() => AuthorizationException();
}

class ApiException implements NetworkError {
  static const unknownCode = -1;

  final String? message;
  final int code;

  const ApiException({ required this.code, this.message });

  factory ApiException.unknown() {
    return const ApiException(code: unknownCode);
  }
}

class AuthorizationException implements ResolvableException, NetworkError {

}

class UnknownNetworkException implements NetworkError {

}

class UnreachableException implements NetworkError {

}