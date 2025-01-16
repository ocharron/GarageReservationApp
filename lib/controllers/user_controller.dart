import 'package:garageauto/controllers/role_controller.dart';
import 'package:garageauto/database/database.dart';
import 'package:garageauto/models/role.dart';
import 'package:garageauto/models/user.dart';

class UserController {
  final RoleController _roleController = const RoleController();

  Future<List<User>> getUsers() async {
    DatabaseHandler databaseHandler = DatabaseHandler();
    List<User> users = [];
  
    List<Map<String, dynamic>>? usersListMap = await databaseHandler.database?.query('User');
  
    if (usersListMap != null && usersListMap.isNotEmpty) {
      List<Future<List<Role>>> rolesFutures = usersListMap.map((user) async {
        return _roleController.getRolesByIdUser(user["id"]);
      }).toList();
  
      List<List<Role>> rolesList = await Future.wait(rolesFutures);
  
      for (int i = 0; i < usersListMap.length; i++) {
        Map<String, dynamic> user = usersListMap[i];
        List<Role> roles = rolesList[i];
  
        users.add(User.fromMap(user, roles));
      }
    }
  
    return users;
  }

  Future<User> getOrInsertUser(String userId, String userName) async {
    DatabaseHandler dbHandler = DatabaseHandler();
    List<Map<String, dynamic>>? userListMap = await dbHandler.database?.query(
      "User",
      where: "id = ?",
      whereArgs: [userId]
    );

    if(userListMap!.isEmpty) {
      User newUtilisateur = User(userId, userName, List<Role>.empty());

      await dbHandler.database?.insert("Utilisateur", newUtilisateur.toMap());

      userListMap = await dbHandler.database?.query(
        "User",
        where: "id = ?",
        whereArgs: [userId]
      );
    }

    List<Role> roles = await _roleController.getRolesByIdUser(userId);

    return User.fromMap(userListMap!.first, roles);
  }

  Future<String> getNameFromId(String id) async {
    Future<List<User>> usersList = getUsers();
    List<User> users = await usersList;
    User user = users.firstWhere((element) => element.id == id);

    return user.name;
  }
}