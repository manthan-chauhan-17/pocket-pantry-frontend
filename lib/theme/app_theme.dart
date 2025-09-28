import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pantry_frontend/colors.dart';

class AppTheme {
  static ColorScheme getColor(BuildContext context) =>
      Theme.of(context).colorScheme;
  // Light Theme
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryBrown,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: ColorScheme.light(
            primary: AppColors.primaryBrown,
            surface: AppColors.lightBackground,
            error: AppColors.error,
            onPrimary: Colors.white,
            onSurface: AppColors.lightTextPrimary,
            onError: Colors.white,
            onSurfaceVariant: AppColors.lightAccent),
        textTheme:
            GoogleFonts.playfairDisplayTextTheme(Theme.of(context).textTheme),
      );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      surface: AppColors.darkBackground,
      error: AppColors.error,
      onPrimary: AppColors.darkAccent,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkBackground,
      onError: Colors.white,
    ),
  );
}


// import 'package:flutter/material.dart';
// import 'package:pocket_pantry_frontend/colors.dart';

// class AppTheme {
//   static ColorScheme getColor(BuildContext context) =>
//       Theme.of(context).colorScheme;

//   // Light Theme
//   static ThemeData lightTheme(BuildContext context) => ThemeData(
//         brightness: Brightness.light,
//         primaryColor: AppColors.lightPrimary,
//         scaffoldBackgroundColor: AppColors.lightBackground,
//         colorScheme: const ColorScheme.light(
//           primary: AppColors.lightPrimary,
//           surface: AppColors.lightBackground,
//           error: AppColors.error,
//           onPrimary: Colors.white,
//           onSurface: AppColors.lightTextPrimary,
//           onError: Colors.white,
//           secondary: AppColors.accentOrange,
//           onSurfaceVariant: AppColors.lightAccent,
//         ),
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
//           bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
//         ),
//       );

//   // Dark Theme
//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: AppColors.darkPrimary,
//     scaffoldBackgroundColor: AppColors.darkBackground,
//     colorScheme: const ColorScheme.dark(
//       primary: AppColors.darkPrimary,
//       surface: AppColors.darkBackground,
//       error: AppColors.error,
//       onPrimary: Colors.white,
//       onSurface: AppColors.darkTextPrimary,
//       onError: Colors.white,
//       secondary: AppColors.accentOrange,
//       onSurfaceVariant: AppColors.darkAccent,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
//       bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
//     ),
//   );
// }