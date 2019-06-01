import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData appTheme = _appTheme();

ThemeData _appTheme() {
  return ThemeData(
      accentColor: accentColor,
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark);
}
