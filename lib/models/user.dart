import 'package:garageauto/models/role.dart';

class User {
  final String id;
  final String name;
  final List<Role> roles;

  const User (this.id, this.name, this.roles);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  User.fromMap(Map<String, dynamic> userMap, List<Role> listRoles): 
    id = userMap['id'],
    name = userMap['name'],
    roles = listRoles;

  @override
  String toString() {
    return '$id: $name {${roles.map((r) => r.toString()).join(", ")}}';
  }
}