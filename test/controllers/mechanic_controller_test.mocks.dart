// Mocks generated by Mockito 5.4.3 from annotations
// in garageauto/test/controllers/mechanic_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:garageauto/controllers/mechanic_controller.dart' as _i3;
import 'package:garageauto/models/mechanic.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

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

class _FakeMechanic_0 extends _i1.SmartFake implements _i2.Mechanic {
  _FakeMechanic_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MechanicController].
///
/// See the documentation for Mockito's code generation for more information.
class MockMechanicController extends _i1.Mock
    implements _i3.MechanicController {
  MockMechanicController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Mechanic>> getMechanics() => (super.noSuchMethod(
        Invocation.method(
          #getMechanics,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Mechanic>>.value(<_i2.Mechanic>[]),
      ) as _i4.Future<List<_i2.Mechanic>>);

  @override
  _i4.Future<_i2.Mechanic> getMechanicFromId(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMechanicFromId,
          [id],
        ),
        returnValue: _i4.Future<_i2.Mechanic>.value(_FakeMechanic_0(
          this,
          Invocation.method(
            #getMechanicFromId,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Mechanic>);

  @override
  _i4.Future<String> getNameFromId(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getNameFromId,
          [id],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #getNameFromId,
            [id],
          ),
        )),
      ) as _i4.Future<String>);
}
