import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/theme_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_controller_test.mocks.dart';

@GenerateMocks([ThemeController])
void main() {
  group("Tests ThemeController", () {
    test("Tester de changer les thèmes de l'application", () async {
      final themeController = MockThemeController();
      const darkTheme = true;

      when(themeController.setDarkTheme(darkTheme)).thenAnswer(
        (_) async => null
      );

      when(themeController.setDarkTheme(!darkTheme)).thenAnswer(
        (_) async => null
      );

      when(themeController.getTheme()).thenAnswer(
        (_) async => darkTheme
      );

      await themeController.setDarkTheme(darkTheme);
      bool theme1 = await themeController.getTheme();
      expect(theme1, darkTheme);
    });
  });
}