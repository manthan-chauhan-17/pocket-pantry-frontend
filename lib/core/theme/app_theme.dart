import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pantry_frontend/core/theme/colors.dart';

class AppTheme {
  static ColorScheme getColor(BuildContext context) =>
      Theme.of(context).colorScheme;

  static bool isAppThemeDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    textTheme: GoogleFonts.playwriteNoTextTheme(),
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundPrimary,
    primaryColor: AppColors.primary,

    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.backgroundPrimary,
      foregroundColor: AppColors.primaryText,
      elevation: 0,
    ),

    // Color theme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.backgroundPrimary,
      error: AppColors.errorBg,
      onError: AppColors.error,
    ),
  );

  // Optional: add this now for future dark mode use
  static ThemeData darkTheme(BuildContext context) => ThemeData(
    textTheme: GoogleFonts.playwriteNoTextTheme(),
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkbackgroundPrimary,
    primaryColor: AppColors.darkPrimary,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: AppColors.darkPrimaryText,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      surface: AppColors.darkbackgroundPrimary,
      error: AppColors.errorBg,
      onError: AppColors.error,
    ),
  );
}
