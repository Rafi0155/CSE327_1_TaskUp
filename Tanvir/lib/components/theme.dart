import 'package:flutter/material.dart';



class MaterialTheme {
  final TextTheme textTheme;
  MaterialTheme(this.textTheme);
  ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      textTheme: textTheme,
      brightness: Brightness.light,
    );
  }
  ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
      useMaterial3: true,
      textTheme: textTheme,
      brightness: Brightness.dark,
    );
  }
}
