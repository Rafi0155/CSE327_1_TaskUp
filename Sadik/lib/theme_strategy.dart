// theme_strategy.dart

abstract class ThemeStrategy {
  String getTheme();
  void setTheme(String theme);
}

class LightThemeStrategy implements ThemeStrategy {
  String _theme = 'Light';

  @override
  String getTheme() => _theme;

  @override
  void setTheme(String theme) {
    _theme = theme;
  }
}

class DarkThemeStrategy implements ThemeStrategy {
  String _theme = 'Dark';

  @override
  String getTheme() => _theme;

  @override
  void setTheme(String theme) {
    _theme = theme;
  }
}
