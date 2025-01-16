class Mechanic {
  const Mechanic({this.id, required this.name});

  final int? id;
  final String name;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name
    };
  }

  Mechanic.fromMap(Map<String, dynamic> mechanicMap):
  id = mechanicMap['id'],
  name = mechanicMap['name'];

  @override
  String toString() {
    return '$id: $name';
  }
}