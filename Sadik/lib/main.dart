// main.dart
import 'package:flutter/material.dart';
// import 'settings_screen.dart';
import 'about_screen.dart';
import 'about_proxy.dart';
import 'auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  late final AboutScreenProxy aboutScreenProxy;

  @override
  void initState() {
    super.initState();
    aboutScreenProxy = AboutScreenProxy(_authService, const AboutScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(_authService.isAuthenticated() ? Icons.logout : Icons.login),
            onPressed: () {
              setState(() {
                if (_authService.isAuthenticated()) {
                  _authService.logout();
                } else {
                  _authService.login();
                }
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _authService.isAuthenticated() ? 'Authenticated' : 'Not Authenticated',
              style: const TextStyle(fontSize: 20),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const SettingsScreen()),
            //     );
            //   },
            //   child: const Text('Settings'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => aboutScreenProxy.getScreen(context)),
                );
              },
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
