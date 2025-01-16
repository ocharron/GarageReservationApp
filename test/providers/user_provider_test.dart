import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garageauto/controllers/providers/user_provider.dart';
import 'package:garageauto/controllers/role_controller.dart';
import 'package:garageauto/controllers/user_controller.dart';
import 'package:garageauto/models/role.dart';
import 'package:garageauto/models/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_provider_test.mocks.dart';

@GenerateMocks([Auth0, WebAuthentication, UserController, RoleController])
void main() {
  group("Authentification", () {
    test("Tester l'authentification des admins", () async {
      final auth0 = MockAuth0();
      final webAuthentification = MockWebAuthentication();
      final userController =  MockUserController();

      when(
        auth0.webAuthentication(
          scheme:"garageauto"
        )
      ).thenReturn(webAuthentification);

      when(
        webAuthentification.login()
      ).thenAnswer(
        (_) async => Credentials(
          idToken: "idToken",
          accessToken: "accessToken",
          expiresAt: DateTime.now(),
          user: const UserProfile(sub: "auth0|657b443a800b946fec8cd8f3", name: "admin@mikesworkshop.com"),
          tokenType: "tokenType"
        )
      );
      
      when(
        userController.getOrInsertUser(
          "auth0|657b443a800b946fec8cd8f3",
          "admin@mikesworkshop.com"
        )
      ).thenAnswer(
        (_) async => User(
          "auth0|657b443a800b946fec8cd8f3",
          "admin@mikesworkshop.com",
          List<Role>.empty()
        )
      );

      final userProvider = UserProvider(auth0, userController);

      await userProvider.loginAction();
      expect(userProvider.isLoggedIn, true);

      await userProvider.logoutAction();
      expect(userProvider.isLoggedIn, false);
    });
  });

  group("Autorisations", () {
    test("Tester l''autorisation des admins", () async {
      final auth0 = MockAuth0();
      final webAuthentification = MockWebAuthentication();
      final userController =  MockUserController();
      final roleController =  MockRoleController();
      
      when(
        auth0.webAuthentication(
          scheme:"garageauto"
        )
      ).thenReturn(webAuthentification);

      when(
        webAuthentification.login()
      ).thenAnswer(
        (_) async => Credentials(
          idToken: "idToken",
          accessToken: "accessToken",
          expiresAt: DateTime.now(),
          user: const UserProfile(sub: "auth0|657b443a800b946fec8cd8f3", name: "admin@mikesworkshop.com"),
          tokenType: "tokenType"
        )
      );

      when(
        roleController.getRolesByIdUser(
          "auth0|657b443a800b946fec8cd8f3"
        )
      ).thenAnswer(
        (_) async => List<Role>.from([
          const Role(
            1,
            "auth0|657b443a800b946fec8cd8f3",
            "admin"
          ),
        ]),
      );
      
      when(
        userController.getOrInsertUser(
          "auth0|657b443a800b946fec8cd8f3",
          "admin@mikesworkshop.com"
        )
      ).thenAnswer(
        (_) async => User(
          "auth0|657b443a800b946fec8cd8f3",
          "admin@mikesworkshop.com",
          await roleController.getRolesByIdUser("auth0|657b443a800b946fec8cd8f3")
        )
      );

      final userProvider = UserProvider(auth0, userController);

      await userProvider.loginAction();
      expect(userProvider.isLoggedIn, true);

      bool hasRole = userProvider.hasRole("admin");
      expect(hasRole, true);

      hasRole = userProvider.hasRole("user");
      expect(hasRole, false);
    });

    test("Tester l'autorisation des users", () async {
      final auth0 = MockAuth0();
      final webAuthentification = MockWebAuthentication();
      final userController =  MockUserController();
      final roleController =  MockRoleController();
      
      when(
        auth0.webAuthentication(
          scheme:"garageauto"
        )
      ).thenReturn(webAuthentification);

      when(
        webAuthentification.login()
      ).thenAnswer(
        (_) async => Credentials(
          idToken: "idToken",
          accessToken: "accessToken",
          expiresAt: DateTime.now(),
          user: const UserProfile(sub: "auth0|6577cfeb34659f99dd98deb7", name: "toto@toto.com"),
          tokenType: "tokenType"
        )
      );

      when(
        roleController.getRolesByIdUser(
          "auth0|6577cfeb34659f99dd98deb7"
        )
      ).thenAnswer(
        (_) async => List<Role>.from([
          const Role(
            2,
            "auth0|6577cfeb34659f99dd98deb7",
            "user"
          ),
        ]),
      );

      when(
        userController.getOrInsertUser(
          "auth0|6577cfeb34659f99dd98deb7",
          "toto@toto.com"
        )
      ).thenAnswer(
        (_) async => User(
          "auth0|6577cfeb34659f99dd98deb7",
          "toto@toto.com",
          await roleController.getRolesByIdUser("auth0|6577cfeb34659f99dd98deb7")
        )
      );

      final userProvider = UserProvider(auth0, userController);

      await userProvider.loginAction();
      expect(userProvider.isLoggedIn, true);

      bool hasRole = userProvider.hasRole("admin");
      expect(hasRole, false);

      hasRole = userProvider.hasRole("user");
      expect(hasRole, true);
    });
  });
}