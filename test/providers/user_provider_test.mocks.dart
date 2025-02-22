// Mocks generated by Mockito 5.4.3 from annotations
// in garageauto/test/providers/user_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:auth0_flutter/auth0_flutter.dart' as _i7;
import 'package:auth0_flutter/src/mobile/authentication_api.dart' as _i3;
import 'package:auth0_flutter/src/mobile/credentials_manager.dart' as _i2;
import 'package:auth0_flutter/src/mobile/web_authentication.dart' as _i4;
import 'package:auth0_flutter_platform_interface/auth0_flutter_platform_interface.dart'
    as _i5;
import 'package:garageauto/controllers/role_controller.dart' as _i11;
import 'package:garageauto/controllers/user_controller.dart' as _i9;
import 'package:garageauto/models/role.dart' as _i12;
import 'package:garageauto/models/user.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCredentialsManager_0 extends _i1.SmartFake
    implements _i2.CredentialsManager {
  _FakeCredentialsManager_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAuthenticationApi_1 extends _i1.SmartFake
    implements _i3.AuthenticationApi {
  _FakeAuthenticationApi_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebAuthentication_2 extends _i1.SmartFake
    implements _i4.WebAuthentication {
  _FakeWebAuthentication_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCredentials_3 extends _i1.SmartFake implements _i5.Credentials {
  _FakeCredentials_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUser_4 extends _i1.SmartFake implements _i6.User {
  _FakeUser_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Auth0].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuth0 extends _i1.Mock implements _i7.Auth0 {
  MockAuth0() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CredentialsManager get credentialsManager => (super.noSuchMethod(
        Invocation.getter(#credentialsManager),
        returnValue: _FakeCredentialsManager_0(
          this,
          Invocation.getter(#credentialsManager),
        ),
      ) as _i2.CredentialsManager);

  @override
  _i3.AuthenticationApi get api => (super.noSuchMethod(
        Invocation.getter(#api),
        returnValue: _FakeAuthenticationApi_1(
          this,
          Invocation.getter(#api),
        ),
      ) as _i3.AuthenticationApi);

  @override
  _i4.WebAuthentication webAuthentication({
    String? scheme,
    bool? useCredentialsManager = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #webAuthentication,
          [],
          {
            #scheme: scheme,
            #useCredentialsManager: useCredentialsManager,
          },
        ),
        returnValue: _FakeWebAuthentication_2(
          this,
          Invocation.method(
            #webAuthentication,
            [],
            {
              #scheme: scheme,
              #useCredentialsManager: useCredentialsManager,
            },
          ),
        ),
      ) as _i4.WebAuthentication);
}

/// A class which mocks [WebAuthentication].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebAuthentication extends _i1.Mock implements _i4.WebAuthentication {
  MockWebAuthentication() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i5.Credentials> login({
    String? audience,
    Set<String>? scopes = const {
      r'openid',
      r'profile',
      r'email',
      r'offline_access',
    },
    String? redirectUrl,
    String? organizationId,
    String? invitationUrl,
    bool? useEphemeralSession = false,
    Map<String, String>? parameters = const {},
    _i5.IdTokenValidationConfig? idTokenValidationConfig =
        const _i5.IdTokenValidationConfig(),
    _i5.SafariViewController? safariViewController,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [],
          {
            #audience: audience,
            #scopes: scopes,
            #redirectUrl: redirectUrl,
            #organizationId: organizationId,
            #invitationUrl: invitationUrl,
            #useEphemeralSession: useEphemeralSession,
            #parameters: parameters,
            #idTokenValidationConfig: idTokenValidationConfig,
            #safariViewController: safariViewController,
          },
        ),
        returnValue: _i8.Future<_i5.Credentials>.value(_FakeCredentials_3(
          this,
          Invocation.method(
            #login,
            [],
            {
              #audience: audience,
              #scopes: scopes,
              #redirectUrl: redirectUrl,
              #organizationId: organizationId,
              #invitationUrl: invitationUrl,
              #useEphemeralSession: useEphemeralSession,
              #parameters: parameters,
              #idTokenValidationConfig: idTokenValidationConfig,
              #safariViewController: safariViewController,
            },
          ),
        )),
      ) as _i8.Future<_i5.Credentials>);

  @override
  _i8.Future<void> logout({String? returnTo}) => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
          {#returnTo: returnTo},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [UserController].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserController extends _i1.Mock implements _i9.UserController {
  MockUserController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i6.User>> getUsers() => (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [],
        ),
        returnValue: _i8.Future<List<_i6.User>>.value(<_i6.User>[]),
      ) as _i8.Future<List<_i6.User>>);

  @override
  _i8.Future<_i6.User> getOrInsertUser(
    String? userId,
    String? userName,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOrInsertUser,
          [
            userId,
            userName,
          ],
        ),
        returnValue: _i8.Future<_i6.User>.value(_FakeUser_4(
          this,
          Invocation.method(
            #getOrInsertUser,
            [
              userId,
              userName,
            ],
          ),
        )),
      ) as _i8.Future<_i6.User>);

  @override
  _i8.Future<String> getNameFromId(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getNameFromId,
          [id],
        ),
        returnValue: _i8.Future<String>.value(_i10.dummyValue<String>(
          this,
          Invocation.method(
            #getNameFromId,
            [id],
          ),
        )),
      ) as _i8.Future<String>);
}

/// A class which mocks [RoleController].
///
/// See the documentation for Mockito's code generation for more information.
class MockRoleController extends _i1.Mock implements _i11.RoleController {
  MockRoleController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i12.Role>> getRolesByIdUser(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRolesByIdUser,
          [userId],
        ),
        returnValue: _i8.Future<List<_i12.Role>>.value(<_i12.Role>[]),
      ) as _i8.Future<List<_i12.Role>>);
}
