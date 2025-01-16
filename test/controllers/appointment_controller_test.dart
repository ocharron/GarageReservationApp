import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/appointment_controller.dart';
import 'package:garageauto/models/appointment.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'appointment_controller_test.mocks.dart';

@GenerateMocks([AppointmentController])
void main() {
  group("Tests AppointmentController", () {
    test("Tester d'obtenir tous les Appointments", () async {
      final appointmentController = AppointmentController();

      final appointments = await appointmentController.getAppointments();
      expect(appointments, isA<List<Appointment>>());
    });

    test("Tester d'obtenir tous les Appointments d'un utilisateur", () async {
      final appointmentController = AppointmentController();
      const userId = "auth0|657b443a800b946fec8cd8f3";
    
      final userAppointments = await appointmentController.getUserAppointments(userId);
    
      final allAppointmentsHaveUserId = userAppointments.every(
        (appointment) => appointment.userId == userId,
      );
    
      expect(userAppointments, isA<List<Appointment>>());
      expect(allAppointmentsHaveUserId, isTrue);
    });


    test("Tester d'obtenir tous les Appointments disponibles", () async {
      final appointmentController = AppointmentController();
      
      final userAppointments = await appointmentController.getAvailableAppointments();
    
      final allAppointmentsAreAvailable = userAppointments.every(
        (appointment) => appointment.userId == null,
      );
    
      expect(userAppointments, isA<List<Appointment>>());
      expect(allAppointmentsAreAvailable, isTrue);
    });

    test("Tester de reserver un Appointment", () async {
      final appointmentController = MockAppointmentController();
      const userId = "auth0|657b443a800b946fec8cd8f3";
      Appointment appointment = Appointment(
        id: 10000,
        date: "2024-01-20 14:00",
        userId: null,
        mechanicId: 1
      );

      when(appointmentController.reserveAppointment(appointment, userId))
        .thenAnswer((_) async {
          appointment.userId = userId;
        }
      );

      expect(appointment.userId, null);

      await appointmentController.reserveAppointment(appointment, userId);

      expect(appointment.userId, "auth0|657b443a800b946fec8cd8f3");
    });

    test("Tester d'annuler un Appointment", () async {
      final appointmentController = MockAppointmentController();
      const userId = "auth0|657b443a800b946fec8cd8f3";
      Appointment appointment = Appointment(
        id: 10000,
        date: "2024-01-20 14:00",
        userId: userId,
        mechanicId: 1
      );

      when(appointmentController.cancelAppointment(appointment))
        .thenAnswer((_) async {
          appointment.userId = null;
        }
      );

      expect(appointment.userId, userId);

      await appointmentController.cancelAppointment(appointment);

      expect(appointment.userId, null);
    });

    test("Test d'ajout d'une disponibilité", () async {
      final appointmentController = MockAppointmentController();
      const mechanicName = "Joe";
      const date = "2024-01-01";
      const time = "12:00";

      await appointmentController.addAppointment(mechanicName, date, time);

      verify(appointmentController.addAppointment(mechanicName, date, time));
    });

    test("Test de suppression d'une disponibilité", () async {
      final appointmentController = MockAppointmentController();
      Appointment appointment = Appointment(
        id: 10000,
        date: "2024-01-20 14:00",
        userId: null,
        mechanicId: 1
      );

      await appointmentController.deleteAppointment(appointment);

      verify(appointmentController.deleteAppointment(appointment));
    });

    test("Tester d'obtenir un Appointment à partir d'un id", () async {
      final appointmentController = MockAppointmentController();
      const appointmentId = 1;

      final simulatedAppointment = Appointment(
        id: appointmentId,
        date: "2024-01-20 14:00",
        userId: null,
        mechanicId: 1,
      );

      when(
        appointmentController.getAppointmentFromId(appointmentId)
      ).thenAnswer(
        (_) async => simulatedAppointment
      );

      final appointment = await appointmentController.getAppointmentFromId(appointmentId);

      expect(appointment.id, appointmentId);
    });
  });
}
