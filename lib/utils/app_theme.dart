import 'package:flutter/material.dart';

class AppTheme {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffF68115),
    onPrimary: Colors.white,
    secondary: Color(0xffea9654),
    onSecondary: Color(0xff000000),
    error: Color(0xffF24545),
    onError: Colors.white,
    background: Color(0xffCCFEE9),
    onBackground: Colors.black,
    surface: Color(0xffCCFEE9),
    onSurface: Colors.black,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffF68115),
    onPrimary: Colors.white,
    secondary: Color(0xffefb383),
    onSecondary: Color(0xff14120e),
    error: Color(0xffF24545),
    onError: Colors.white,
    background: Color(0xff393939),
    onBackground: Colors.white,
    surface: Color(0xff393939),
    onSurface: Colors.white,
  );
}
