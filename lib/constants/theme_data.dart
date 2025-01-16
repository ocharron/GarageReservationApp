import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(BuildContext context, bool isDarkTheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: const Color.fromARGB(255, 206, 114, 1),
        onPrimary: const Color.fromRGBO(144,78,0,1),
        secondary: Colors.blue,
        onSecondary: isDarkTheme ? const Color.fromRGBO(32,27,23,1) : Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        background: isDarkTheme ? const Color.fromRGBO(32,27,23,1) : Colors.white,
        onBackground: Colors.black,
        surface: isDarkTheme ? const Color.fromRGBO(32,27,23,1) : Colors.white,
        onSurface: isDarkTheme ? Colors.white : Colors.black,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
    );
  }
}