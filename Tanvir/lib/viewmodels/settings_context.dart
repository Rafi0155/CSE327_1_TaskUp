

import '../models/settings_strategy.dart';

class SettingsContext {
  SettingsStrategy? _strategy;

  void setStrategy(SettingsStrategy strategy) {
    _strategy = strategy;
  }

  void applySettings() {
    _strategy?.applySettings();
  }
}