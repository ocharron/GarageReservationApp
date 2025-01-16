import 'package:garageauto/database/database.dart';
import 'package:garageauto/models/role.dart';

class RoleController {
  const RoleController();

  Future<List<Role>> getRolesByIdUser(String userId) async{
    DatabaseHandler databaseHandler = DatabaseHandler();

    List<Map<String, dynamic>>? roleListMap = await databaseHandler.database!.query(
      "Role",
      where: "userId = ?",
      whereArgs: [userId]
    );

    return roleListMap.map((r) => Role.fromMap(r)).toList();
  }
}