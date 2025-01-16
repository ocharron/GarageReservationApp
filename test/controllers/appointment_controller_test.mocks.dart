// Mocks generated by Mockito 5.4.3 from annotations
// in garageauto/test/controllers/appointment_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:garageauto/controllers/appointment_controller.dart' as _i3;
import 'package:garageauto/models/appointment.dart' as _i2;
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

class _FakeAppointment_0 extends _i1.SmartFake implements _i2.Appointment {
  _FakeAppointment_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AppointmentController].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppointmentController extends _i1.Mock
    implements _i3.AppointmentController {
  MockAppointmentController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Appointment>> getAppointments() => (super.noSuchMethod(
        Invocation.method(
          #getAppointments,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.Appointment>>.value(<_i2.Appointment>[]),
      ) as _i4.Future<List<_i2.Appointment>>);

  @override
  _i4.Future<List<_i2.Appointment>> getUserAppointments(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserAppointments,
          [userId],
        ),
        returnValue:
            _i4.Future<List<_i2.Appointment>>.value(<_i2.Appointment>[]),
      ) as _i4.Future<List<_i2.Appointment>>);

  @override
  _i4.Future<List<_i2.Appointment>> getAvailableAppointments() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAvailableAppointments,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.Appointment>>.value(<_i2.Appointment>[]),
      ) as _i4.Future<List<_i2.Appointment>>);

  @override
  _i4.Future<void> reserveAppointment(
    _i2.Appointment? appointment,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #reserveAppointment,
          [
            appointment,
            userId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> cancelAppointment(_i2.Appointment? appointment) =>
      (super.noSuchMethod(
        Invocation.method(
          #cancelAppointment,
          [appointment],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> addAppointment(
    String? mechanicName,
    String? date,
    String? time,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addAppointment,
          [
            mechanicName,
            date,
            time,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> deleteAppointment(_i2.Appointment? appointment) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAppointment,
          [appointment],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.Appointment> getAppointmentFromId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAppointmentFromId,
          [id],
        ),
        returnValue: _i4.Future<_i2.Appointment>.value(_FakeAppointment_0(
          this,
          Invocation.method(
            #getAppointmentFromId,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Appointment>);
}
