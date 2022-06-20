import 'dart:io';

abstract class NetworkError implements IOException {

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

class AuthorizationException implements NetworkError {

}

class UnknownNetworkException implements NetworkError {

}

class UnreachableException implements NetworkError {

}