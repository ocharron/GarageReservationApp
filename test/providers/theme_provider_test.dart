import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group("Tests ThemeProvider", () {
    test("Tester le changement de thème", () async {
      final themeProvider = ThemeProvider();

      themeProvider.setDarkTheme = false;
      expect(themeProvider.getDarkTheme, false);

      await Future.delayed(Duration.zero);

      themeProvider.setDarkTheme = true;
      expect(themeProvider.getDarkTheme, true);
    });
  });
}