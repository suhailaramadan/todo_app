import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier{
  String Language="en";
  ThemeMode themeMode=ThemeMode.light;
  bool get isDark=>themeMode==ThemeMode.dark;
  void changeThemeMode(ThemeMode slectedThemeMode){
    themeMode=slectedThemeMode;
    notifyListeners();
  }
  void changeLanguage(String selectedLanguage){
    Language=selectedLanguage;
    notifyListeners();
  }
}