import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textLight,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textDark,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColors.textDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textDark,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textDark,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: AppColors.textLight,
        fontSize: 12,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent),
  );
}
