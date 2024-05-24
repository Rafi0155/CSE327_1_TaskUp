// auth_service.dart
class AuthService {
  bool _isAuthenticated = false;

  bool isAuthenticated() {
    return _isAuthenticated;
  }

  void login() {
    _isAuthenticated = true;
  }

  void logout() {
    _isAuthenticated = false;
  }
}
