// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'home_page.dart';
// import 'login_or_register_page.dart';
// import 'login_page.dart';
//
// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot){
//           // user is logged in
//           if(snapshot.hasData){
//             return HomePage();
//           }
//           // user is not logged in
//           else{
//             return LoginOrRegisterPage();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_or_register_page.dart';

class AuthProxy {
  final Stream<User?> _authStateStream = FirebaseAuth.instance.authStateChanges();

  Stream<User?> get authStateStream => _authStateStream;

  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;
}

class AuthPage extends StatelessWidget {
  final AuthProxy _authProxy = AuthProxy();

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: _authProxy.authStateStream,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
