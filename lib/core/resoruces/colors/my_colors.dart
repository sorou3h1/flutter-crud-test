import 'package:flutter/material.dart';
abstract class MyColors {
  // late final String key;
  late final Color background;
  late final Color onBackground;
  late final Color onSurface;
  late final Color surface;

  late final Color primary;
  late final Color onPrimary;

  late final Color secondary;
  late final Color onSecondary;

  late final Brightness brightness;

  // factory MyColors.fromMap(Map<String, dynamic> map) {
  //   switch (map["key"]) {
  //     case darkThemeKey:
  //       return DarkThemeColors();
  //     case darkTheme2Key:
  //       return DarkThemeColors2();
  //     case darkTheme3Key:
  //       return DarkThemeColors3();
  //     case lightThemeKey:
  //       return LightThemeColors();
  //     default:
  //       return DarkThemeColors();
  //   }
  // }
}
