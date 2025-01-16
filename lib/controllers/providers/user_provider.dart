import 'package:garageauto/controllers/user_controller.dart';
import 'package:garageauto/models/user.dart';
import 'package:garageauto/models/role.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';

const appSchema = "garageauto";

class UserProvider extends ChangeNotifier {
  late Auth0 _auth0;
  Credentials? _credentials;
  User? _user;
  late bool _isAuthenticating;
  late String _errorMessage;
  late UserController _userController;

  List<Role>? get roles => _user?.roles;

  bool get isAuthenticating => _isAuthenticating;
  String get errorMessage => _errorMessage;
  Uri? get pictureUrl => _credentials?.user.pictureUrl;
  String? get name => _credentials?.user.name;
  String? get id => _credentials?.user.sub;
  bool get isLoggedIn => _credentials != null;

  bool hasRole(String role) {
    return roles?.any((r) => r.role == role) ?? false;
  }

  UserProvider(Auth0 auth0, UserController userController){
    _auth0 = auth0;
    _errorMessage = '';
    _isAuthenticating = false;
    _userController = userController;
  }

  Future<void> loginAction() async {
    _isAuthenticating = true;
    _errorMessage = '';

    notifyListeners();

    try {
      final Credentials credentials = await _auth0.webAuthentication(scheme: appSchema).login();

      User user = await _userController.getOrInsertUser(credentials.user.sub, credentials.user.name ?? '');

      _credentials = credentials;
      _user = user;
      _isAuthenticating = false;
      notifyListeners();

    } on Exception catch (e, s) {
      debugPrint('Login error: $e - stack: $s');

      _isAuthenticating = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> logoutAction() async {
    await _auth0.webAuthentication(scheme: appSchema).logout();

    _user = null;
    _credentials = null;
    notifyListeners();
  }
}