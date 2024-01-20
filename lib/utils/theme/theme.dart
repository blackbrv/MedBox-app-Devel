import 'package:flutter/material.dart';
import 'package:medapp/utils/theme/text_field_theme.dart';
import 'package:medapp/utils/theme/text_theme.dart';

class mAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: mtextTheme.lightTextTheme,
    inputDecorationTheme: mTextFieldTheme.lightInputDecoration,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: mtextTheme.darkTextTheme,
    inputDecorationTheme: mTextFieldTheme.darkInputDecoration,
  );
}
