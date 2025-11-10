import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette - matching your design system
  static const Color primary600 = Color(0xFF3F51B5);   // Indigo 600
  static const Color secondary600 = Color(0xFF0E8074); // Teal 600
  static const Color accent500 = Color(0xFFF59E0B);    // Gold 500
  
  // Backgrounds
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF1F5F9);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF334155);
  static const Color textDisabled = Color(0xFF94A3B8);
  
  // Status Colors
  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xDC2626);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF2563EB);
  
  // Spacing Scale (4px base)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusCircular = 999.0;
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary600,
        brightness: Brightness.light,
        primary: primary600,
        secondary: secondary600,
        tertiary: accent500,
        surface: surface,
        background: background,
        error: error,
      ),
      fontFamily: 'Inter',
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: background,
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary600,
        brightness: Brightness.dark,
        primary: primary600,
        secondary: secondary600,
        tertiary: accent500,
        error: error,
      ),
      fontFamily: 'Inter',
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
    );
  }
  
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32, height: 1.25, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 24, height: 1.33, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontSize: 20, height: 1.4, fontWeight: FontWeight.w700),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, height: 1.43, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, height: 1.5, fontWeight: FontWeight.w400),
  );
  
  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primary600,
      foregroundColor: Colors.white,
      minimumSize: const Size(88, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
      elevation: 0,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
  
  static final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: secondary600,
      side: const BorderSide(color: secondary600),
      minimumSize: const Size(88, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
  
  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primary600,
      minimumSize: const Size(88, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
  
  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: BorderSide(color: primary600.withOpacity(0.3), width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing16),
    labelStyle: const TextStyle(color: textSecondary),
    hintStyle: const TextStyle(color: textDisabled),
  );
  
  static final CardTheme _cardTheme = CardTheme(
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.08),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLarge)),
    margin: const EdgeInsets.all(spacing8),
  );
  
  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: surface,
    foregroundColor: textPrimary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );
}