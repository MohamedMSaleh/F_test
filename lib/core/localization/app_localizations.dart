import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Common
  String get appTitle => _localizedValue('SpeakX', 'سبيك إكس');
  String get home => _localizedValue('Home', 'الرئيسية');
  String get learningJourney => _localizedValue('Learning Journey', 'رحلة التعلم');
  String get challenges => _localizedValue('Challenges', 'التحديات');
  String get tutor => _localizedValue('Tutor', 'المعلم');
  String get rooms => _localizedValue('Rooms', 'الغرف');
  String get profile => _localizedValue('Profile', 'الملف الشخصي');
  String get settings => _localizedValue('Settings', 'الإعدادات');
  
  // Practice
  String get vocabulary => _localizedValue('Vocabulary', 'المفردات');
  String get grammar => _localizedValue('Grammar', 'القواعد');
  String get pronunciation => _localizedValue('Pronunciation', 'النطق');
  String get fluency => _localizedValue('Fluency', 'الطلاقة');
  
  // Actions
  String get start => _localizedValue('Start', 'ابدأ');
  String get resume => _localizedValue('Resume', 'استكمل');
  String get complete => _localizedValue('Complete', 'أكمل');
  String get practice => _localizedValue('Practice', 'تمرن');
  String get assess => _localizedValue('Assess', 'قيّم');
  
  // Assessment
  String get overallScore => _localizedValue('Overall Score', 'النتيجة الإجمالية');
  String get progressThisWeek => _localizedValue('Progress This Week', 'التقدم هذا الأسبوع');
  String get weeklyStreak => _localizedValue('Weekly Streak', 'السلسلة الأسبوعية');
  
  // Messages
  String get welcomeMessage => _localizedValue(
    'Welcome to SpeakX! Your AI-powered English fluency coach.',
    'مرحباً بك في سبيك إكس! مدربك الذكي لتطوير طلاقة الإنجليزية.',
  );
  
  String _localizedValue(String en, String ar) {
    return locale.languageCode == 'ar' ? ar : en;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}