/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'package:flutter/foundation.dart';

/* Created by Bholendra Singh  */
class AppLogger {
  AppLogger(dynamic state) {
    if (kDebugMode) {
      print("************************ Current Page " +
          state.toString() +
          " ************************");
    }
  }
}
