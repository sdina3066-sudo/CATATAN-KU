import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Warna utama aplikasi
class AppColors {
  static const primary = Color(0xFF2E7D32);
  static const secondary = Color(0xFF66BB6A);
  static const background = Color(0xFFF1F8E9);
  static const coin = Color(0xFFFFB300);
  static const textPrimary = Color(0xFF1B1B1B);
  static const textSecondary = Color(0xFF6B7280);
}

/// Tema global (Material 3 + font Poppins)
class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.background,
    );

    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
