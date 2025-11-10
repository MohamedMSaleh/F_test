import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme get textTheme => GoogleFonts.interTextTheme().copyWith(
        // Headings
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          height: 1.25, // 40px line height
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          height: 1.33, // 32px line height
          fontWeight: FontWeight.w700,
          letterSpacing: -0.01,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 20,
          height: 1.4, // 28px line height
          fontWeight: FontWeight.w600,
          letterSpacing: -0.01,
        ),
        
        // Body text
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          height: 1.5, // 24px line height
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          height: 1.43, // 20px line height
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          height: 1.33, // 16px line height
          fontWeight: FontWeight.w400,
        ),
        
        // Labels
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          height: 1.43, // 20px line height
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          height: 1.33, // 16px line height
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          height: 1.45, // 16px line height
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        
        // Titles
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          height: 1.33, // 24px line height
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          height: 1.5, // 24px line height
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          height: 1.43, // 20px line height
          fontWeight: FontWeight.w500,
        ),
        
        // Display text
        displayLarge: GoogleFonts.inter(
          fontSize: 40,
          height: 1.2, // 48px line height
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 36,
          height: 1.22, // 44px line height
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 28,
          height: 1.29, // 36px line height
          fontWeight: FontWeight.w700,
          letterSpacing: -0.01,
        ),
      );

  // Arabic typography fallback
  static TextTheme get arabicTextTheme => GoogleFonts.cairoTextTheme().copyWith(
        headlineLarge: GoogleFonts.cairo(
          fontSize: 32,
          height: 1.25,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.cairo(
          fontSize: 24,
          height: 1.33,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: GoogleFonts.cairo(
          fontSize: 20,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          height: 1.43,
          fontWeight: FontWeight.w400,
        ),
      );

  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
}