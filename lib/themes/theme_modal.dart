import 'package:flutter/material.dart';
import 'package:todo_app/themes/theme_share_preferences.dart';

class ThemeModal extends ChangeNotifier {
  late bool _isDark;
  late ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;

  ThemeModal() {
    _isDark = false;
    themeSharedPreferences = ThemeSharedPreferences();
    getThemePreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();
  }

  getThemePreferences() async {
    _isDark = await themeSharedPreferences.getTheme();
    notifyListeners();
  }
}
