import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:task_up/pages/auth_page.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'components/util.dart';
import 'components/theme.dart';
import 'pages/login_page.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyCQNafg_r-LwDydkix9EZV5EuewVR_7Zv8",
  //           authDomain: "taskup-20655.firebaseapp.com",
  //           projectId: "taskup-20655",
  //           storageBucket: "taskup-20655.appspot.com",
  //           messagingSenderId: "637638792097",
  //           appId: "1:637638792097:web:5693b2186a48d2b4dcb1e0"));
  // } else if (Platform.isAndroid) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyBNgd5MEHSzNoGJm9X-HWK_XilfjhNy38Q",
  //           projectId: "taskup-20655",
  //           messagingSenderId: "637638792097",
  //           appId: "1:637638792097:android:941a8975eca9a0c0dcb1e0"));
  // } else {
  //   await Firebase.initializeApp();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //textTheme: GoogleFonts.poppinsTextTheme(),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        //colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      /*
      darkTheme: ThemeData.dark().copyWith(
        // Set the primary color for dark mode
        colorScheme: ThemeData.dark().colorScheme.copyWith(primary: Colors.green),
      ),
      */
      themeMode: ThemeMode.system,
      home: LoginPage(),
    );
  }
}

   */
  @override
  Widget build(BuildContext context) {
    //final brightness = View.of(context).platformDispatcher.platformBrightness;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskUp',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: AuthPage(),
    );
  }
}
