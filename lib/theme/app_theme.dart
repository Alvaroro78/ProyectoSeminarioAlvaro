import 'package:flutter/material.dart';

/// App color palette definition.
abstract final class AppColors {
  static const Color primary = Color(0xFF4453C9);
  static const Color background = Color(0xFFFBFBFD);
  static const Color border = Color(0xFFDCDDE6);
  static const Color draft = Color(0xFF79809A);
  static const Color published = Color(0xFF0F8478);
  static const Color closed = Color(0xFF454C61);
  static const Color recommendationBackground = Color(0xFFFFF3DC);
  static const Color recommendationBorder = Color(0xFFF0C572);
  static const Color recommendationTitle = Color(0xFFA96C05);
  static const Color late = Colors.red;
}

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      surface: AppColors.background,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
