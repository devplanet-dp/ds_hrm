import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final ThemeData themeData = new ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
    brightness: Brightness.light,
    backgroundColor:kAltWhite,
    scaffoldBackgroundColor: kAltWhite,
    primaryColor: kcPrimaryColor,
    primaryColorBrightness: Brightness.light,
    accentColor: kcAccent,
    accentColorBrightness: Brightness.light);

final ThemeData themeDataDark = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
  brightness: Brightness.dark,
  backgroundColor: kAltBg,
  scaffoldBackgroundColor: kBlack,
  primaryColor: kcPrimaryColor,
  primaryColorBrightness: Brightness.dark,
  accentColor: kcAccent,
  accentColorBrightness: Brightness.dark,
);
