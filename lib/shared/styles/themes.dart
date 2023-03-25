import 'package:expert_system/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemes {
  static final primaryColor = Colors.red.shade300;

  static final darkTheme = ThemeData(
    primaryColor: primary,
    useMaterial3: true,

    appBarTheme: const AppBarTheme(
      color: darkerBlue,
      elevation: 0,
    ),
    navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: darkerBlue, indicatorColor: primary),

    checkboxTheme: const CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(primary),
        ),
    scaffoldBackgroundColor: darkBlue,
    primaryColorDark: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primary, background: darkBlue),
    tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.2)),
    // floatingActionButtonTheme:
    //     const FloatingActionButtonThemeData(backgroundColor: primary),

    listTileTheme:
        const ListTileThemeData(textColor: Colors.white, tileColor: darkerBlue),
    cardColor: darkerBlue,
    cardTheme: const CardTheme(color: darkerBlue, surfaceTintColor: darkerBlue),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
    )),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    // primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      // backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.black,

    tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black.withOpacity(0.3)),
     navigationRailTheme: NavigationRailThemeData(
      elevation: 20,
      selectedIconTheme: const IconThemeData(color: Colors.white),
         backgroundColor: ThemeData.light().cardColor, indicatorColor: primary),

    listTileTheme: const ListTileThemeData(textColor: Colors.black),
    // cardColor: Colors.grey.shade200,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.black),
    )),
  );
}

class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme = false;
  SharedPreferences? _preferences;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _loadSettingsFromPrefs();
  }

  _initializePrefs() async {
    // if (_preferences == null){
    _preferences ??= await SharedPreferences.getInstance();
  }

  _loadSettingsFromPrefs() async {
    await _initializePrefs();
    _darkTheme = _preferences?.getBool('darkTheme') ?? false;
    notifyListeners();
  }

  _saveSettingsToPrefs() async {
    await _initializePrefs();
    _preferences?.setBool('darkTheme', _darkTheme);
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveSettingsToPrefs();
    notifyListeners();
  }
}
