import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/theme.dart';
import 'Theme.Notifier.dart';
import 'components/util.dart';
import 'views/settings_screen.dart';

void main() => runApp(
 ChangeNotifierProvider(
  create: (_) => ThemeNotifier(),
  child: MyApp(),
 ),
);

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return Consumer<ThemeNotifier>(
   builder: (context, themeNotifier, child) {
    MaterialTheme theme = MaterialTheme(Theme
        .of(context)
        .textTheme);

    return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'TaskUp',
     theme: theme.light(),
     darkTheme: theme.dark(),
     themeMode: themeNotifier.themeMode,
     home: SettingsScreen(),
    );
   },
  );
 }
}

