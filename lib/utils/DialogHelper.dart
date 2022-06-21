import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogHelper {
  BuildContext? _dialogContext;

  void showLoading(BuildContext context) {
    showDialog(context: context, builder: (dialogContext) {
      _dialogContext = dialogContext;
      return const Center(
        child: SpinKitDoubleBounce(
          color: Colors.blueAccent,
        ),
      );
    });
  }

  void hideLoading() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!, rootNavigator: true).pop();
      _dialogContext = null;
    }
  }

  static Future<dynamic> showMessage(BuildContext context, String message) {
    return showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: Text("Message"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext, rootNavigator: true).pop();
          },
          child: Text("Ok"),
        )
      ],
    ));
  }
}