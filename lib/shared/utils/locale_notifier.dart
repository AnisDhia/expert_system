import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends ChangeNotifier {
  String _locale = 'en';
  SharedPreferences? _preferences;

  String get locale => _locale;

  LocaleNotifier() {
    _loadSettingsFromPrefs();
  }

  _initializePrefs() async {
    // if (_preferences == null){
    _preferences ??= await SharedPreferences.getInstance();
  }

  _loadSettingsFromPrefs() async {
    await _initializePrefs();
    _locale = _preferences?.getString('locale') ?? 'en';
    notifyListeners();
  }

  _saveSettingsToPrefs() async {
    await _initializePrefs();
    _preferences?.setString('locale', _locale);
  }

  void changeLocale(String newLocale) {
    _locale = newLocale;
    _saveSettingsToPrefs();
    notifyListeners();
  }
}