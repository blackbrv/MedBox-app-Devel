import 'package:flutter/material.dart';
import 'package:medapp/utils/colors.dart';

class mTextFieldTheme {
  static final lightInputDecoration = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: mSecondaryColorLightOpac,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: mSecondaryColor,
      ),
    ),
  );

  static final darkInputDecoration = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: mPrimaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: mAccentColor,
      ),
    ),
  );
}
