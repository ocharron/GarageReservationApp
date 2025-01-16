import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/mechanic_controller.dart';
import 'package:garageauto/models/mechanic.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mechanic_controller_test.mocks.dart';

@GenerateMocks([MechanicController])
void main() {
  group("Tests MechanicController", () {
    test("Tester d'obtenir tous mécaniciens", () async {
      final mechanicController = MechanicController();

      final mechanics = await mechanicController.getMechanics();
      expect(mechanics, isA<List<Mechanic>>());
    });

    test("Tester d'obtenir un mécanicien par son id", () async {
      final mechanicController = MockMechanicController();
      const mechanicId = 1;

      when(mechanicController.getMechanicFromId(mechanicId)).thenAnswer(
        (_) async => const Mechanic(
          id: mechanicId,
          name: "Mike"
        )
      );

      final mechanic = await mechanicController.getMechanicFromId(mechanicId);
      expect(mechanic.id, mechanicId);
    });

    test("Tester d'obtenir le nom d'un mécanicien par son id", () async {
      final mechanicController = MockMechanicController();
      const mechanicId = 1;
      const mechanicName = "Mike";

      when(mechanicController.getNameFromId(mechanicId)).thenAnswer(
        (_) async => mechanicName
      );

      String mechanicNameFromId = await mechanicController.getNameFromId(mechanicId);
      expect(mechanicNameFromId, mechanicName);
    });
  });
}