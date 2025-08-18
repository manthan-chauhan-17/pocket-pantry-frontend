import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';

class AppTheme {
  static ColorScheme getColor(BuildContext context) =>
      Theme.of(context).colorScheme;
  // Light Theme
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.lightPrimaryGreen,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: ColorScheme.light(
          primary: AppColors.lightPrimaryGreen,
          surface: AppColors.lightBackground,
          error: AppColors.darkError,
          onPrimary: Colors.white,
          onSurface: AppColors.greenText,
          onError: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.lightTextSecondary),
          bodyMedium: TextStyle(color: AppColors.greenText),
        ),
      );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      surface: AppColors.darkBackground,
      error: AppColors.darkError,
      onPrimary: AppColors.darkAccent,
      onSurface: AppColors.darkGreenTextField,
      onError: Colors.white,
    ),
  );
}
