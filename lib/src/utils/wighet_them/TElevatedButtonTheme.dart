import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/sizes.dart';


class TElevatedButtonTheme{
  static final lightElevatedBTN=  ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tSecondaryColor,
        backgroundColor: tPrimaryColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(
            vertical: tButtonHeight)),
  );


  static final darkElevatedBTN=  ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tSecondaryColor,
        backgroundColor: twhiteColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(
            vertical: tButtonHeight)),
  );
}