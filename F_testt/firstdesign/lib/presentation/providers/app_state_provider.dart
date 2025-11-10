import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isFirstTime = true;
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en', 'US');
  bool _isRTL = false;

  bool get isFirstTime => _isFirstTime;
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isRTL => _isRTL;

  void completeOnboarding() {
    _isFirstTime = false;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _isRTL = locale.languageCode == 'ar';
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      setLocale(const Locale('ar', 'EG'));
    } else {
      setLocale(const Locale('en', 'US'));
    }
  }
}