import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xFF5D9CEC);
  static Color backgroundLight = Color(0xFFDFECDB);
  static Color backgroundDark = Color(0xFF200E32);
  static Color white = Color(0xFFFFFFFF);
  static Color grey = Color(0xFFC8C9CB);
  static Color black = Color(0xFF141922);
  static Color green = Color(0xFF61E757);
  static Color red = Color(0xFFEC4B4B);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: AppTheme.backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.white,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppTheme.primary,
      elevation: 0,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(color: AppTheme.white, width: 4)),
    ),
    textTheme: TextTheme(
        titleMedium: TextStyle(
            fontWeight: FontWeight.bold, color:AppTheme.black, fontSize: 20),
        titleSmall: TextStyle(
            color: AppTheme.grey, fontWeight: FontWeight.w700, fontSize: 20)),
    appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: Colors.transparent)
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: AppTheme.backgroundDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.black,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppTheme.primary,
      elevation: 0,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(color: AppTheme.white, width: 4)),
    ),
    textTheme: TextTheme(
        titleMedium: TextStyle(
            fontWeight: FontWeight.bold, color: AppTheme.black, fontSize: 18),
        titleSmall: TextStyle(
            color: AppTheme.grey, fontWeight: FontWeight.w700, fontSize: 18)),
        appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: Colors.transparent,)
  );
}
