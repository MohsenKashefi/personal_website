import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application theme configuration with stunning dark and light modes
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ==================== DARK THEME COLORS ====================
  // Glamorous dark theme with depth and sophistication
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color darkSurface = Color(0xFF151B3D);
  static const Color darkCard = Color(0xFF1E2749);
  
  // Vibrant accent colors
  static const Color primaryGreen = Color(0xFF00FFA3);
  static const Color primaryPurple = Color(0xFF7B2FF7);
  static const Color accentPink = Color(0xFFFF0080);
  static const Color accentBlue = Color(0xFF00D9FF);
  
  // Text colors
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB8C5D6);
  static const Color darkTextMuted = Color(0xFF6B7A8F);

  // ==================== LIGHT THEME COLORS ====================
  // Clean, modern light theme
  static const Color lightBackground = Color(0xFFFAFBFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F7FA);
  
  // Light mode accents
  static const Color lightPrimary = Color(0xFF6366F1);
  static const Color lightSecondary = Color(0xFF8B5CF6);
  static const Color lightAccent = Color(0xFFEC4899);
  
  // Light text colors
  static const Color lightText = Color(0xFF1F2937);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextMuted = Color(0xFF9CA3AF);

  // ==================== SHARED COLORS ====================
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  /// Stunning dark theme with glassmorphism and gradients
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        secondary: primaryPurple,
        tertiary: accentPink,
        surface: darkSurface,
        background: darkBackground,
        error: error,
        onPrimary: darkBackground,
        onSecondary: darkText,
        onSurface: darkText,
        onBackground: darkText,
      ),
      
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkText),
        titleTextStyle: GoogleFonts.poppins(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: darkText, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: darkText, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: darkText, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: darkText, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(color: darkText, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: darkText, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: darkText, fontWeight: FontWeight.w500),
          titleMedium: TextStyle(color: darkText, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: darkText, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: darkTextSecondary),
          bodyMedium: TextStyle(color: darkTextSecondary),
          bodySmall: TextStyle(color: darkTextMuted),
        ),
      ),
      
      // Card Theme
      cardTheme: const CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryGreen,
        size: 24,
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: darkBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Beautiful light theme with modern aesthetics
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightSecondary,
        tertiary: lightAccent,
        surface: lightSurface,
        background: lightBackground,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: lightText,
        onBackground: lightText,
      ),
      
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightCard,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: lightText),
        titleTextStyle: GoogleFonts.poppins(
          color: lightText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: lightText, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: lightText, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: lightText, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: lightText, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(color: lightText, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: lightText, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: lightText, fontWeight: FontWeight.w500),
          titleMedium: TextStyle(color: lightText, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: lightText, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: lightTextSecondary),
          bodyMedium: TextStyle(color: lightTextSecondary),
          bodySmall: TextStyle(color: lightTextMuted),
        ),
      ),
      
      // Card Theme
      cardTheme: const CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: lightPrimary,
        size: 24,
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


