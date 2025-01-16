import 'package:flutter/material.dart';
import 'package:garageauto/controllers/theme_controller.dart';

class ThemeProvider with ChangeNotifier {
  ThemeController themeController = ThemeController();
  bool darkTheme = false;

  bool get getDarkTheme => darkTheme;
  
  set setDarkTheme(bool value) {
    darkTheme = value;
    themeController.setDarkTheme(value);
    notifyListeners();
  }
}