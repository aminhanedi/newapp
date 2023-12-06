import 'package:flutter/material.dart';
import '../constants/color.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: tSecondaryColor,
          floatingLabelStyle: TextStyle(color: tSecondaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: tSecondaryColor),
          )); // OutlineInputBorder, InputDecorationTheme

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: tPrimaryColor,
          floatingLabelStyle: TextStyle(color: tPrimaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: tPrimaryColor),
          )); // OutlineInputBorder, InputDecorationTheme
}
