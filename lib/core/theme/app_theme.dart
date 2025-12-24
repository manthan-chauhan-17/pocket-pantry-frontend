import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pantry_frontend/core/theme/colors.dart';

class AppTheme {
  static ColorScheme getColor(BuildContext context) =>
      Theme.of(context).colorScheme;

  static bool isAppThemeDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  // Helper method to get surface container color (for cards, search bars, etc.)
  static Color getSurfaceContainer(BuildContext context) {
    return isAppThemeDarkMode(context)
        ? AppColors.darkSurfaceContainer
        : AppColors.surfaceContainer;
  }

  // Helper method to get text color on surface container
  static Color getOnSurfaceContainer(BuildContext context) {
    return isAppThemeDarkMode(context)
        ? AppColors.darkOnSurfaceContainer
        : AppColors.onSurfaceContainer;
  }

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    // textTheme: GoogleFonts.playwriteNoTextTheme(),
    textTheme: GoogleFonts.mochiyPopPOneTextTheme(),
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

    // Color Scheme - defines all colors used throughout the app
    // Change these colors to easily update the entire app theme
    colorScheme: const ColorScheme.light(
      // Primary color - main brand color, used for buttons, app bars, and key actions
      primary: AppColors.primary,

      // Text/icon color on primary background - ensures readable text on primary colored surfaces
      onPrimary: AppColors.onPrimary,

      // Primary container - lighter version of primary, used for containers and cards with primary theme
      primaryContainer: AppColors.primaryContainer,

      // Text/icon color on primary container
      onPrimaryContainer: AppColors.onPrimaryContainer,

      // Secondary color - secondary brand color, used for secondary actions and accents
      secondary: AppColors.secondary,

      // Text/icon color on secondary background - ensures readable text on secondary colored surfaces
      onSecondary: AppColors.onSecondary,

      // Secondary container - lighter version of secondary, used for containers with secondary theme
      secondaryContainer: AppColors.secondaryContainer,

      // Text/icon color on secondary container
      onSecondaryContainer: AppColors.onSecondaryContainer,

      // Tertiary color - additional accent color for variety
      tertiary: AppColors.tertiary,

      // Text/icon color on tertiary background
      onTertiary: AppColors.onTertiary,

      // Tertiary container - container using tertiary color
      tertiaryContainer: AppColors.tertiaryContainer,

      // Text/icon color on tertiary container
      onTertiaryContainer: AppColors.onTertiaryContainer,

      // Error color - used for error states, validation errors, and destructive actions
      error: AppColors.error,

      // Text/icon color on error background - ensures readable text on error colored surfaces
      onError: AppColors.onError,

      // Error container - background color for error messages and error states
      errorContainer: AppColors.errorContainer,

      // Text/icon color on error container
      onErrorContainer: AppColors.onErrorContainer,

      // Background color - main app background color
      background: AppColors.backgroundPrimary,

      // Text/icon color on background - used for text directly on app background
      onBackground: AppColors.onBackground,

      // Surface color - used for cards, dialogs, sheets, and elevated surfaces
      surface: AppColors.backgroundPrimary,

      // Text/icon color on surface - used for text on cards, dialogs, and other surfaces
      onSurface: AppColors.onSurface,

      // Surface variant - slightly different surface color for elevation and variety
      surfaceContainerHighest: AppColors.surfaceVariant,

      // Text/icon color on surface variant
      onSurfaceVariant: AppColors.onSurfaceVariant,

      // Outline color - used for borders, dividers, and input field borders
      outline: AppColors.outline,

      // Outline variant - lighter outline for subtle borders and dividers
      outlineVariant: AppColors.outlineVariant,

      // Shadow color - used for elevation shadows (usually black with opacity)
      shadow: Colors.black,

      // Scrim color - used for modal overlays and backdrops
      scrim: Colors.black,

      // Inverse surface - inverse of surface, used for special cases
      inverseSurface: AppColors.primary,

      // Text/icon color on inverse surface
      onInverseSurface: AppColors.onPrimary,

      // Inverse primary - inverse of primary color
      inversePrimary: AppColors.secondary,
    ),
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    textTheme: GoogleFonts.playwriteNoTextTheme(),
    // textTheme: GoogleFonts.arimaTextTheme(),
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkbackgroundPrimary,
    primaryColor: AppColors.darkPrimary,

    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.darkbackgroundPrimary,
      foregroundColor: AppColors.darkPrimaryText,
      elevation: 0,
    ),

    // Color Scheme - defines all colors used throughout the app in dark mode
    // Change these colors to easily update the entire dark theme
    colorScheme: const ColorScheme.dark(
      // Primary color - main brand color for dark mode, used for buttons, app bars, and key actions
      primary: AppColors.darkPrimary,

      // Text/icon color on primary background - ensures readable text on primary colored surfaces
      onPrimary: AppColors.darkOnPrimary,

      // Primary container - darker version of primary, used for containers and cards with primary theme
      primaryContainer: AppColors.darkPrimaryContainer,

      // Text/icon color on primary container
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,

      // Secondary color - secondary brand color for dark mode, used for secondary actions and accents
      secondary: AppColors.darkSecondary,

      // Text/icon color on secondary background - ensures readable text on secondary colored surfaces
      onSecondary: AppColors.darkOnSecondary,

      // Secondary container - darker version of secondary, used for containers with secondary theme
      secondaryContainer: AppColors.darkSecondaryContainer,

      // Text/icon color on secondary container
      onSecondaryContainer: AppColors.darkOnSecondaryContainer,

      // Tertiary color - additional accent color for variety in dark mode
      tertiary: AppColors.darkTertiary,

      // Text/icon color on tertiary background
      onTertiary: AppColors.darkOnTertiary,

      // Tertiary container - container using tertiary color
      tertiaryContainer: AppColors.darkTertiaryContainer,

      // Text/icon color on tertiary container
      onTertiaryContainer: AppColors.darkOnTertiaryContainer,

      // Error color - used for error states, validation errors, and destructive actions
      error: AppColors.error,

      // Text/icon color on error background - ensures readable text on error colored surfaces
      onError: AppColors.darkOnError,

      // Error container - background color for error messages and error states in dark mode
      errorContainer: AppColors.darkErrorContainer,

      // Text/icon color on error container
      onErrorContainer: AppColors.darkOnErrorContainer,

      // Background color - main app background color for dark mode
      background: AppColors.darkbackgroundPrimary,

      // Text/icon color on background - used for text directly on app background
      onBackground: AppColors.darkOnBackground,

      // Surface color - used for cards, dialogs, sheets, and elevated surfaces in dark mode
      surface: AppColors.darkbackgroundPrimary,

      // Text/icon color on surface - used for text on cards, dialogs, and other surfaces
      onSurface: AppColors.darkOnSurface,

      // Surface variant - slightly different surface color for elevation and variety
      surfaceContainerHighest: AppColors.darkSurfaceVariant,

      // Text/icon color on surface variant
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,

      // Outline color - used for borders, dividers, and input field borders in dark mode
      outline: AppColors.darkOutline,

      // Outline variant - lighter outline for subtle borders and dividers
      outlineVariant: AppColors.darkOutlineVariant,

      // Shadow color - used for elevation shadows (usually black with opacity)
      shadow: Colors.black,

      // Scrim color - used for modal overlays and backdrops
      scrim: Colors.black,

      // Inverse surface - inverse of surface, used for special cases
      inverseSurface: AppColors.darkPrimary,

      // Text/icon color on inverse surface
      onInverseSurface: AppColors.darkOnPrimary,

      // Inverse primary - inverse of primary color
      inversePrimary: AppColors.darkSecondary,
    ),
  );
}
