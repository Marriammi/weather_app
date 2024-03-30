import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      secondary: const Color.fromARGB(255, 33, 33, 33),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color.fromARGB(255, 27, 26, 26),
      secondary: const Color.fromARGB(255, 224, 224, 224),
    ));
