import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier{
  ThemeMode themeMode=ThemeMode.light;
  bool get isDark=>themeMode==ThemeMode.dark;
  void changeThemeMode(ThemeMode slectedThemeMode){
    themeMode=slectedThemeMode;
    notifyListeners();
  }
}