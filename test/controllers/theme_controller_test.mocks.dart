// Mocks generated by Mockito 5.4.3 from annotations
// in garageauto/test/controllers/theme_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:garageauto/controllers/theme_controller.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ThemeController].
///
/// See the documentation for Mockito's code generation for more information.
class MockThemeController extends _i1.Mock implements _i2.ThemeController {
  MockThemeController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  dynamic setDarkTheme(bool? value) => super.noSuchMethod(Invocation.method(
        #setDarkTheme,
        [value],
      ));

  @override
  _i3.Future<bool> getTheme() => (super.noSuchMethod(
        Invocation.method(
          #getTheme,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
