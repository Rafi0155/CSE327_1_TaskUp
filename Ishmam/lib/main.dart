import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/screens/pag2dummy.dart';
import 'components/theme.dart';
import 'components/util.dart';
import 'firebase_options.dart';
import 'screens/task_detail_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {

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
      home: TaskDetailScreen(),
    );

  }
}



