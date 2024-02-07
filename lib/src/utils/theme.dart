import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newapp/src/utils/wighet_them/TElevatedButtonTheme.dart';
import 'package:newapp/src/utils/wighet_them/TOutlineButtonTheme.dart';
class AppTheme{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 20,
      )
    ),
      outlinedButtonTheme: TOutlineButtonTheme.lightOutlineBTN,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedBTN,
  );

  static ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(
  titleMedium: GoogleFonts.montserrat(
  color: Colors.white,
  fontSize: 26,
  )
  ),
      outlinedButtonTheme: TOutlineButtonTheme.darkOutlineBTN,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedBTN
  );

}