import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/ui/base/base_stateful.dart';
import 'package:flutter_kd/ui/screens.dart';
import 'package:flutter_kd/utils/DialogHelper.dart';

class IllegalStateException implements Exception {
  final String? message;

  IllegalStateException({ this.message });
}

class ParseException implements Exception {
  final dynamic innerException;

  ParseException({ this.innerException });
}

abstract class ResolvableException {

}

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    String message = 'An error occurred ${error.runtimeType}';
    if (error is ApiException) {
      message = 'An error occurred message ${error.message}, code: ${error.code}';
    } else if (error is UnknownNetworkException) {

    } else if (error is UnreachableException) {
      message = 'A network error occurred, please check your network';
    } else {
      message = 'An error occurred ${error.runtimeType}';
    }

    return  message;
  }


  static void handleAuthorizationError(BaseStateful<dynamic> host) async {
    await DialogHelper.showMessage(host.context, ApiConst.tokenExpiredMessage);
    host.getNav()?.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }
}