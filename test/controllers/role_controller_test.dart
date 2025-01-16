import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/role_controller.dart';
import 'package:garageauto/models/role.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../controllers/role_controller_test.mocks.dart';

@GenerateMocks([RoleController])
void main() {
  group("Tests RoleController", () {
    test("Tester d'obtenir tous les roles d'un utilisateur", () async {
      final roleController = MockRoleController();
      const userId = "auth0|657b443a800b946fec8cd8f3";

      when(roleController.getRolesByIdUser(userId)).thenAnswer(
        (_) async => <Role>[]
      );

      final userRoles = await roleController.getRolesByIdUser(userId);
      expect(userRoles, isA<List<Role>>());
    });
  });
}