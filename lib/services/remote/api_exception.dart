
class ApiException implements Exception {
  static const unknownCode = -1;

  final String? message;
  final int code;
  final String? body;

  const ApiException({ required this.code, this.message, this.body });

  factory ApiException.unknown() {
    return const ApiException(code: unknownCode);
  }
}

class AuthorizationException implements Exception {

}