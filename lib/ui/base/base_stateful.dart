import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/ui/event.dart';
import 'package:flutter_kd/utils/DialogHelper.dart';
import 'package:flutter_kd/utils/exception.dart';

abstract class BaseStateful<T extends StatefulWidget> extends State<T> {
  late DialogHelper dialogHelper;

  @mustCallSuper
  void onNewEvent(Event event) {
    DialogHelper.showMessage(context, "Unknown event ${event.runtimeType.toString()}");
  }

  NavigatorState? getNav() {
    if (mounted) {
      return Navigator.of(context);
    } else {
      return null;
    }
  }

  void handleError(dynamic error) {
    if (error is AuthorizationException) {
      ErrorHandler.handleAuthorizationError(this);
    } else {
      DialogHelper.showMessage(context, ErrorHandler.getErrorMessage(error));
    }
  }

  @override
  void initState() {
    super.initState();
    dialogHelper = DialogHelper();
  }
}