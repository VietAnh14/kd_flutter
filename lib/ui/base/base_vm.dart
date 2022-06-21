import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kd/ui/event.dart';
import 'package:flutter_kd/utils/exception.dart';

class BaseVM extends ChangeNotifier {
  var _isDispose = false;
  final eventStream = StreamController<Event>.broadcast();
  Stream<Event> get event => eventStream.stream;
  final errorStream = StreamController<dynamic>.broadcast();
  Stream<dynamic> get error => errorStream.stream;

  void sendError(dynamic error, stack) {
    print(stack);
    errorStream.add(error);
  }

  void sendEvent(Event event) {
    eventStream.add(event);
  }

  Future<void> safeCall({
    required Function block,
    Function(dynamic error, dynamic stack)? onError,
    Function? onFinally}) async {
    try {
      await block();
    } on ResolvableException catch (error, stack) {
      sendError(error, stack);
    } catch (e, stack) {
      onError?.call(e, stack);
    } finally {
      onFinally?.call();
    }
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    errorStream.close();
    eventStream.close();
    super.dispose();
  }
}