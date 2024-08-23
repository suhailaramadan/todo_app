import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier{
  String Language="ar";
  ThemeMode themeMode=ThemeMode.light;
  bool get isDark=>themeMode==ThemeMode.dark;
Future<void> changeThemeMode(ThemeMode slectedThemeMode)async{
    themeMode=slectedThemeMode;
    notifyListeners();
  }
  Future<void> changeLanguage(String selectedLanguage)async{
    Language=selectedLanguage;
    notifyListeners();
  }
}