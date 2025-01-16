import 'package:garageauto/database/database.dart';
import 'package:garageauto/models/mechanic.dart';

class MechanicController {
  Future<List<Mechanic>> getMechanics() async {
    DatabaseHandler databaseHandler = DatabaseHandler();
    List<Mechanic> mechanics = [];

    List<Map<String, dynamic>>? mechanicListMap = await databaseHandler.database?.query('Mechanic') ;

    if (mechanicListMap != null)
    {
      for(Map<String, dynamic> mechanic in mechanicListMap){
        mechanics.add(Mechanic.fromMap(mechanic));
      }
    }

    return mechanics;
  }

  Future<Mechanic> getMechanicFromId(int id) async {
    List<Mechanic> mechanics = await getMechanics();
    Mechanic mechanic = mechanics.firstWhere((element) => element.id == id);

    return mechanic;
  }

  Future<String> getNameFromId(int id) async {
    List<Mechanic> mechanics = await getMechanics();
    Mechanic mechanic = mechanics.firstWhere((element) => element.id == id);

    return mechanic.name;
  }
}