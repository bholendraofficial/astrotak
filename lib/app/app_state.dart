/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'package:flutter/material.dart';

class AppState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback voidCallback) {
    if (mounted) {
      super.setState(voidCallback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
