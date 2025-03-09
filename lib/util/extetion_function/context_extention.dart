import 'package:flutter/material.dart';

extension contextExtention on State {
  TextTheme getThemeText() {
    return Theme.of(context).textTheme;
  }
}
