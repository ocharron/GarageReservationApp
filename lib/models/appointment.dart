class Appointment {
  Appointment({this.id, required this.date, this.userId, required this.mechanicId});

  final int? id;
  final String date;
  final int mechanicId;
  String? userId;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'date' : date,
      'userId' : userId,
      'mechanicId' : mechanicId
    };
  }

  Appointment.fromMap(Map<String, dynamic> appointmentMap):
    id = appointmentMap['id'],
    date = appointmentMap['date'],
    userId = appointmentMap['userId'],
    mechanicId = appointmentMap['mechanicId'];

  @override
  String toString() {
    return '$id: $userId w/ $mechanicId ($date)';
  }
}