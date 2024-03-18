import 'package:flutter/material.dart';
import 'package:osta_user_app/utils/constants/colors.dart';

class OAppTheme {
  OAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    brightness: Brightness.light,
    primaryColor: OColors.primaryColor500,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    brightness: Brightness.dark,
    primaryColor: OColors.primaryColor500,
  );
}
