import 'package:flutter/material.dart';
import 'package:student_services/utility/constans.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    primaryColor: Colors.red.shade800,
    accentColor: mainColor,
    buttonTheme: ButtonThemeData(
      buttonColor: mainColor,
    ),
  );
}
