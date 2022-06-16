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
      print(_dialogContext.toString());
      Navigator.of(_dialogContext!, rootNavigator: true).pop();
    }
  }

  static void showMessage(BuildContext context, String message) {
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
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