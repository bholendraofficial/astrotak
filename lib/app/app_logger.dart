import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger(dynamic state) {
    if (kDebugMode) {
      print("************************ Current Page " +
          state.toString() +
          " ************************");
    }
  }
}
