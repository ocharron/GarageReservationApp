import 'package:garageauto/controllers/mechanic_controller.dart';
import 'package:garageauto/database/database.dart';
import 'package:garageauto/models/appointment.dart';
import 'package:garageauto/models/mechanic.dart';
import 'package:collection/collection.dart';

class AppointmentController {
  final MechanicController _mechanicController = MechanicController();

  Future<List<Appointment>> getAppointments() async {
    DatabaseHandler databaseHandler = DatabaseHandler();

    List<Appointment> appointments = [];
    List<Map<String,dynamic>>? appointmentsListMap = await databaseHandler.database?.query(
      'Appointment',
      orderBy: 'date ASC'
    );

    if (appointmentsListMap != null) {
      for (Map<String, dynamic> appointment in appointmentsListMap) {
        appointments.add(Appointment.fromMap(appointment));
      }
    }
    
    return appointments;
  }

  Future<List<Appointment>> getUserAppointments(String userId) async {
    DatabaseHandler databaseHandler = DatabaseHandler();

    List<Appointment> appointments = [];
    List<Map<String,dynamic>>? appointmentsListMap = await databaseHandler.database?.query(
      'Appointment',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date ASC',
    );

    if (appointmentsListMap != null)
    {
      for(Map<String,dynamic> appointment in appointmentsListMap) {
        appointments.add(Appointment.fromMap(appointment));
      }
    }
    
    return appointments;
  }

  Future<List<Appointment>> getAvailableAppointments() async {
    DatabaseHandler databaseHandler = DatabaseHandler();

    List<Appointment> appointments = [];
    List<Map<String, dynamic>>? appointmentsListMap = await databaseHandler.database?.query(
      'Appointment',
      where: 'userId IS NULL',
      orderBy: 'date ASC',
    );

    if (appointmentsListMap != null)
    {
      for(Map<String,dynamic> appointment in appointmentsListMap) {
        appointments.add(Appointment.fromMap(appointment));
      }
    }
    
    return appointments;
  }

  Future<void> reserveAppointment(Appointment appointment, String userId) async {
    DatabaseHandler databaseHandler = DatabaseHandler();
    
    appointment.userId = userId;
    
    await databaseHandler.database?.update(
      'Appointment',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<void> cancelAppointment(Appointment appointment) async {
    DatabaseHandler databaseHandler = DatabaseHandler();
    
    appointment.userId = null;
    
    await databaseHandler.database?.update(
      'Appointment',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<void> addAppointment(String mechanicName, String date, String time) async {
    DatabaseHandler databaseHandler = DatabaseHandler();

    List<Mechanic> mechanics = await _mechanicController.getMechanics();
    Mechanic mechanic = mechanics.firstWhere((element) => element.name == mechanicName);
    
    String fullDate = "$date $time";

    Appointment appointment = Appointment(
      date: fullDate, mechanicId: mechanic.id!
    );

    await databaseHandler.database?.insert('Appointment', appointment.toMap());
  }

  Future<void> deleteAppointment (Appointment appointment) async {
    DatabaseHandler databaseHandler = DatabaseHandler();
    await databaseHandler.database?.delete(
      'Appointment',
      where: 'id = ?',
      whereArgs: [appointment.id]
    );
  }

  Future<Appointment> getAppointmentFromId(int id) async {
    List<Appointment> appointments = await getAppointments();

    // Utilisez firstWhereOrNull au lieu de firstWhere
    Appointment? appointment = appointments.firstWhereOrNull((element) => element.id == id);

    if (appointment == null) {
      print("Aucun rendez-vous trouvé avec l'ID $id");
    }

    return appointment!;
  }
}