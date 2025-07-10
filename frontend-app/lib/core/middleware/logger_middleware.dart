import 'package:flutter/foundation.dart';

class LoggerMiddleware {
  static void log(String message, {String tag = 'LOG'}) {
    if (kDebugMode) {
      print('[$tag] $message');
    }
  }
}

