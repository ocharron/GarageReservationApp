import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/user_controller.dart';
import 'package:garageauto/models/role.dart';
import 'package:garageauto/models/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../controllers/user_controller_test.mocks.dart';

@GenerateMocks([UserController])
void main() {
  group("Tests UserController", () {
    test("Tester d'obtenir tous les utilisateurs", () async {
      final userController = UserController();

      final users = await userController.getUsers();
      expect(users, isA<List<User>>());
    });

    test("Tester d'obtenir un utilisateur papr son id et son name", () async {
      final userController = MockUserController();
      const userId = "auth0|657b443a800b946fec8cd8f3";
      const userName = "admin@mikesworkshop.com";

      when(
        userController.getOrInsertUser(
          userId,
          userName
        )
      ).thenAnswer(
        (_) async => User(
          userId,
          userName,
          List<Role>.empty()
        )
      );

      User user = await userController.getOrInsertUser(userId, userName);
      expect(user.id, userId);
      expect(user.name, userName);
    });

    test("Tester d'obtenir le nom d'un utilisateur pas son id", () async {
      final userController = MockUserController();
      const userId = "auth0|657b443a800b946fec8cd8f3";
      const userName = "admin@mikesworkshop.com";

      when(
        userController.getOrInsertUser(
          userId,
          userName
        )
      ).thenAnswer(
        (_) async => User(
          userId,
          userName,
          List<Role>.empty()
        )
      );

      when(
        userController.getNameFromId(
          userId
        )
      ).thenAnswer(
        (_) async => userName
      );

      User user = await userController.getOrInsertUser(userId, userName);
      String userNameById = await userController.getNameFromId(userId);

      expect(user.name, userNameById);
    });
  });
}