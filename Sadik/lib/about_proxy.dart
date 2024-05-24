// about_proxy.dart

import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'auth_service.dart';

abstract class AboutScreenInterface {
  Widget getScreen(BuildContext context);
}

class AboutScreenProxy implements AboutScreenInterface {
  final AuthService _authService;
  final AboutScreen _realAboutScreen;

  AboutScreenProxy(this._authService, this._realAboutScreen);

  @override
  Widget getScreen(BuildContext context) {
    if (_authService.isAuthenticated()) {
      return _realAboutScreen;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: const Center(
          child: Text('You need to be authenticated to view this page.'),
        ),
      );
    }
  }
}
