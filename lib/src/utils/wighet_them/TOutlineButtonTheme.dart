
  import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/sizes.dart';

class TOutlineButtonTheme{
  static final lightOutlineBTN= OutlinedButtonThemeData(
  style: ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(),
  backgroundColor: tSecondaryColor,
  elevation: 0,
  foregroundColor: twhiteColor,
  side: BorderSide(color: tSecondaryColor),
  padding: EdgeInsets.symmetric(
  vertical: tButtonHeight)),

  );
  static final darkOutlineBTN= OutlinedButtonThemeData(
  style: ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(),
  backgroundColor: tSecondaryColor,
  elevation: 0,
  foregroundColor: twhiteColor,
  side: BorderSide(color: twhiteColor),
  padding: EdgeInsets.symmetric(
  vertical: tButtonHeight)),
  );


  }