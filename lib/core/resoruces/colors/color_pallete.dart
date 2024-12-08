import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mc_crud_test/core/resoruces/colors/my_colors.dart';
// ignore: must_be_immutable
class DarkThemeColors extends Equatable implements MyColors {
  // @override
  // String key = darkThemeKey;

  @override
  Color background = const Color.fromARGB(255, 16, 22, 30);

  @override
  Color onPrimary = const Color.fromARGB(255, 0, 0, 0);

  @override
  Color onSecondary = const Color.fromARGB(255, 0, 0, 0);
  @override
  Color primary = const Color.fromARGB(255, 134, 183, 184);

  @override
  Color secondary = const Color.fromARGB(255, 158, 253, 231);

  @override
  Color surface = const Color.fromARGB(255, 53, 61, 72);

  @override
  Color onBackground = const Color.fromARGB(255, 255, 255, 255);

  @override
  Color onSurface = const Color.fromARGB(255, 255, 255, 255);

  @override
  Brightness brightness = Brightness.dark;

  @override
  List<Object?> get props => [
        background,
        onPrimary,
        onSecondary,
        primary,
        secondary,
        surface,
        onBackground,
        onSurface,
        brightness,
      ];

  @override
  bool? get stringify => true;
}

// ignore: must_be_immutable
class DarkThemeColors2 extends Equatable implements MyColors {
  // @override
  // String key = darkTheme2Key;

  @override
  Color background = const Color(0xFF07161b);

  @override
  Color onPrimary = const Color.fromARGB(255, 0, 0, 0);

  @override
  Color onSecondary = const Color.fromARGB(255, 255, 255, 255);
  @override
  Color primary = const Color(0xFF3d737f);

  @override
  Color secondary = const Color.fromARGB(255, 240, 159, 66);

  @override
  Color surface = const Color.fromARGB(255, 18, 60, 74);

  @override
  Color onBackground = const Color.fromARGB(255, 255, 255, 255);

  @override
  Color onSurface = const Color.fromARGB(255, 255, 255, 255);

  @override
  Brightness brightness = Brightness.dark;

  @override
  List<Object?> get props => [
        background,
        onPrimary,
        onSecondary,
        primary,
        secondary,
        surface,
        onBackground,
        onSurface,
        brightness,
      ];

  @override
  bool? get stringify => true;
}

// ignore: must_be_immutable
class DarkThemeColors3 extends Equatable implements MyColors {
  // @override
  // String key = darkTheme3Key;

  @override
  Color background = const Color(0xFF333c4b);

  @override
  Color onPrimary = const Color.fromARGB(255, 255, 255, 255);

  @override
  Color onSecondary = const Color.fromARGB(255, 255, 255, 255);
  @override
  Color primary = const Color.fromARGB(255, 172, 125, 58);

  @override
  Color secondary = const Color(0xFFd4a056);

  @override
  Color surface = const Color(0xFF4a4c5c);

  @override
  Color onBackground = const Color.fromARGB(255, 255, 255, 255);

  @override
  Color onSurface = const Color.fromARGB(255, 255, 255, 255);

  @override
  Brightness brightness = Brightness.dark;

  @override
  List<Object?> get props => [
        background,
        onPrimary,
        onSecondary,
        primary,
        secondary,
        surface,
        onBackground,
        onSurface,
        brightness,
      ];

  @override
  bool? get stringify => true;
}

// ignore: must_be_immutable
class LightThemeColors extends Equatable implements MyColors {
  // @override
  // String key = lightThemeKey;

  @override
  Color background = const Color.fromARGB(255, 246, 237, 236);

  @override
  Color onPrimary = Colors.white;

  @override
  Color onSecondary = Colors.white;

  @override
  Color primary = const Color.fromARGB(255, 252, 204, 218);

  @override
  Color secondary = const Color.fromARGB(255, 1, 0, 49);

  @override
  Color surface = const Color.fromARGB(255, 225, 225, 225);

  @override
  Color onBackground = Colors.black;

  @override
  Color onSurface = const Color.fromARGB(255, 0, 0, 0);

  @override
  Brightness brightness = Brightness.light;

  @override
  List<Object?> get props => [
        background,
        onPrimary,
        onSecondary,
        primary,
        secondary,
        surface,
        onBackground,
        onSurface,
        brightness,
      ];

  @override
  bool? get stringify => true;
}


// ignore: must_be_immutable
class LightThemeColors2 extends Equatable implements MyColors {
  // @override
  // String key = lightThemeKey;

  @override
  Color background = const Color(0xfff0f1f1);

  @override
  Color onPrimary = Colors.white;

  @override
  Color onSecondary = Colors.white;

  @override
  Color primary = const Color(0xff3a30c7);

  @override
  Color secondary = const Color.fromARGB(255, 1, 0, 49);

  @override
  Color surface = const Color(0xfffffdfc);

  @override
  Color onBackground = Colors.black;

  @override
  Color onSurface = const Color(0xff333434);

  @override
  Brightness brightness = Brightness.light;

  @override
  List<Object?> get props => [
        background,
        onPrimary,
        onSecondary,
        primary,
        secondary,
        surface,
        onBackground,
        onSurface,
        brightness,
      ];

  @override
  bool? get stringify => true;
}
