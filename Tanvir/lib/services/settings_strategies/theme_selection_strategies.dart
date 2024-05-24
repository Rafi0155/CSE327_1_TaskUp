

import 'package:flutter/material.dart';
//import'D:\testproject\lib\components\theme.dart';
import '../../models/settings_strategy.dart';

 class ThemeSelectionStrategy implements SettingsStrategy {
  final String theme;

  ThemeSelectionStrategy(this.theme);

  @override
  void applySettings() {
   // Apply the selected theme
   print('Applying theme: $theme');

    // Here you would implement the logic to change the theme of the app
   }
  }
