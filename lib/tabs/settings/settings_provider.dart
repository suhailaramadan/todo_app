import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier{
  String Language="ar";
  ThemeMode themeMode=ThemeMode.light;
  bool get isDark=>themeMode==ThemeMode.dark;
  void changeThemeMode(ThemeMode selectedThemeMode){
    themeMode=selectedThemeMode;
    setThemeToCash(themeMode);
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage){
    Language=selectedLanguage;
    setLangToCash(Language);
    notifyListeners();
  }
  Future setThemeToCash(ThemeMode themeMode)async{
    final prefs=await SharedPreferences.getInstance();
    String themeName=themeMode==ThemeMode.dark?"Dark":"Light";
    await prefs.setString('theme',themeName);
  }
  Future loadTheme()async{
    final prefs=await SharedPreferences.getInstance();
    String? themeName = prefs.getString('theme');
    if(themeName!=null){
      themeMode=themeName=="Dark"?ThemeMode.dark:ThemeMode.light;
      notifyListeners();
    }
  }
  Future setLangToCash(String lang)async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setString("lang",lang);

  }
  Future loadLang()async{
    final prefs=await SharedPreferences.getInstance();
    String language= prefs.getString("lang")??"ar";
    Language=language;
    notifyListeners();

  }
}