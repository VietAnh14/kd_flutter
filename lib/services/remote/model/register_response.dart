
class RegisterResponseData {
  final String? email;
  final int id;
  RegisterResponseData({ this.email, required this.id });
}


class RegisterResponse {
  final bool? success;
  final String? message;
  final RegisterResponseData? data;

  RegisterResponse({ this.success, this.message, this.data });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    final data = RegisterResponseData(
        id: dataJson['id'],
      email: dataJson['email']
    );
    return RegisterResponse(
      success: json['success'],
      message: json['message'],
      data: data
    );
  }
}