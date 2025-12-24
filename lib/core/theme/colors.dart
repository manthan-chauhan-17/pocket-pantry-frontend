import 'package:flutter/material.dart';

// class AppColors {
//   // Primary and Secondary Colors
//   static const Color primary = Color(0xFF2F648E);
//   static const Color primaryAlpha = Color(0x402F648E);
//   static const Color primaryAlpha15 = Color(0x262F648E);
//   static const Color secondary = Color(0xFF2FBBA4);
//   static const Color myCoCyan = Color(0xFF08A4BB);
//   static const Color backgroundPrimary = Color(0xFFFAFAFF);
//   static const Color bgWhite = Color(0xFFFFFFFF);

//   // Text
//   static const Color textPrimary = Color(0xFF101828);
//   static const Color textSecondary = Color(0xFF475467);
//   static const Color textGray = Color(0xFF7C7C7C);

//   // Surface
//   static const Color surfacePrimary = Color(0xFFF5F5F5);

//   // Border
//   static const Color textFieldBorder = Color(0xFF98A2B3);

//   // general
//   static const Color spanishYellow = Color(0xFFFDB913);
//   static const Color black = Color(0xFF000000);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color gray5 = Color(0xFFF2F2F2);
//   static const Color gray10 = Color(0xFFE6E6E6);
//   static const Color error = Color(0xFFE53935);
//   static const Color removeBackground = Color(0xFFFFE5E5);
//   static const Color splashBg = Color(0xFFFBFBFB);
//   static const Color blueLightShade = Color(
//     0xFFeef1f9,
//   ); // use in take order expansion tile
//   static const Color lightTeal = Color(0xFFEEF7FD);
//   static const Color red = Color(0xFFC44141);

//   static const Color borderColor = Color(0xFF98A2B3);
//   static const Color textPrimary2 = Color(0xFF344054);
//   static const Color textGrey200 = Color(0xFFEAECF0);
//   static const Color textBorder300 = Color(0xFFD0D5DD);

//   //sign in
//   // static const Color textGray = Color(0xFF475467);
//   static const Color lightPurple = Color(0xFFF4F3FF);
//   static const Color gray = Color(0xFF98A2B3);
//   static const Color containerHigh = Color(0xFFDCEFFF);
//   static const Color primaryLight = Color(0xFFDCEFFF);

//   //================================================================
//   // Dark Mode Colors
//   //================================================================

//   // Primary and Secondary Colors
//   static const Color darkprimary = Color(0xFF60A5FA); // Lighter blue variant
//   static const Color darksecondary = Color(
//     0xFF2FBBA4,
//   ); // Can stay the same or use a lighter teal
//   static const Color darkmyCoCyan = Color(
//     0xFF5EEAD4,
//   ); // Softer cyan for dark BG
//   static const Color darkbackgroundPrimary = Color(
//     0xFF0D1117,
//   ); // Very dark background (GitHub-like)

//   // Text
//   static const Color darktextPrimary = Color(
//     0xFFF9FAFB,
//   ); // Light near-white text
//   static const Color darktextSecondary = Color(
//     0xFFCBD5E1,
//   ); // Light gray-blue for subtext

//   // Surface
//   static const Color darksurfacePrimary = Color(
//     0xFF1E293B,
//   ); // Slightly elevated dark surface

//   // Border
//   static const Color darkTextFieldBorder = Color(
//     0xFF2F343B,
//   ); // Muted blue-gray border
//   static const Color containerGrey = Color(0xFFF9FAFB);
//   static const Color lightBlue = Color(0xFFDEE5EF);
//   static const Color littleDarkBlue = Color(0xFF5B84A6);

//   static const Color deleteIcon = Color(0xFFD01515);
//   static const Color greenDark = Color(0xFF4FC44B);
//   static const Color containerHighDark = Color(0xFF1E2A36);
//   static const Color transparent = Colors.transparent;

//   static const Color onPrimaryContainerDark = Color(0xff2A2C38);

//   // Stepper color
//   static const Color stepperDenied = Color(0xFFFF2121);
//   static const Color stepperDisabled = Color(0xFFCACACA);
//   static const Color stepperDisabledTitle = Color(0xFFAFA8A8);
//   // static const Color stepperPending = Color(0xFFFDB913);
//   // static const Color stepperCompleted = Color(0xFF2FBBA4);
//   // static const Color stepperAuthorized = Color(0xFF2FBBA4);
//   // static const Color stepperApproved = Color(0xFF2FBBA4);
//   // static const Color stepperDataBorder = Color(0xFF98A2B3);

//   //card header color
//   static const Color redCard = Color(0xFFDA4343);

//   // TimeSheet Calendar decorators Colors
//   static const Color absentDays = Color(0xFFDD4646);

//   // Face Recognition Colors
//   static const Color faceRecognitionTeal = Color(0xFF2FBBA4);
//   static const Color faceRecognitionYellow = Color(0xFFFDB913);
//   static const Color faceRecognitionSuccess = Color(0xFF4FC44B);
//   static const Color faceRecognitionError = Color(0xFFE53935);
//   static const Color faceRecognitionWarning = Color(0xFFFFA726);
//   static const Color faceRecognitionDarkBg = Color(0xFF1E293B);
//   static const Color faceRecognitionLightBg = Color(0xFFF9FAFB);
//   static const Color faceRecognitionBorder = Color(0xFF08A4BB);
//   static const Color faceRecognitionProgress = Color(0xFF2F648E);
//   static const Color punchMissingDays = Color(0xFFFD6513);
//   static const Color pendingDays = Color(0xFFFDB913);
//   static const Color leaveDays = Color(0xFFC756FF);
//   static const Color holidayDays = Color(0xFF08A4BB);
//   static const Color presentDays = Color(0xFF2FBBA4);
//   static const Color weekOffDays = Color(0xFF939393);
//   static const Color wfhAppliedDays = Color(0xFF9BDCA8); // WFH applied color

//   // TimeSheet ProgressBar Colors
//   static const Color emptyProgressLight = Color(0xFFD8EEFF);
//   static const Color emptyProgressDark = Color(0xFFD8EEFF);

//   static const Color blackShade = Color(0xFF525252);
//   static const Color blackShade2 = Color(0xFF3F434A);
//   static const Color blackShade3 = Color(0xFF222222);
//   static const Color blackShade4 = Color(0xFF333333);
//   static const Color blackShade5 = Color(0xFF363636);
//   static const Color blackShade6 = Color(0xFF2E3642);

//   static const Color grey_3 = Color(0xFFf7f7f7);
//   static const Color grey_5 = Color(0xFFf2f2f2);
//   static const Color grey_10 = Color(0xFFe6e6e6);
//   static const Color grey_20 = Color(0xFFcccccc);
//   static const Color grey_40 = Color(0xFF999999);
//   static const Color grey_50 = Color(0xFF929292);
//   static const Color grey_60 = Color(0xFF666666);
//   static const Color grey_70 = Color(0xFF595959);
//   static const Color grey_80 = Color(0xFF37474F);
//   static const Color grey_90 = Color(0xFF263238);

//   static const Color greyShade = Color(0xFF898989);
//   static const Color greyShade2 = Color(0xFFD9D9D9);

//   static const Color primaryLite = Color(0xFFC7D5E3);
// }

class AppColors {
  // ================================================================
  // LIGHT MODE COLORS
  // ================================================================

  // Primary brand color - used for main actions, buttons, and key UI elements
  static const Color primary = Color(0xFF57531e);

  // Secondary brand color - used for secondary actions and accents
  static const Color secondary = Color(0xFFedeada);

  // Background color - main app background
  static const Color backgroundPrimary = Color(0xFFFAFAFF);

  // Primary text color - main text color for content
  static const Color primaryText = Color(0xFF57531e);

  // Text/icon color on primary background - ensures contrast on primary colored surfaces
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Text/icon color on secondary background - ensures contrast on secondary colored surfaces
  static const Color onSecondary = Color(0xFF57531e);

  // Text/icon color on surface - used for text on cards, dialogs, and other surfaces
  static const Color onSurface = Color(0xFF57531e);

  // Text/icon color on background - used for text directly on app background
  static const Color onBackground = Color(0xFF57531e);

  // Surface variant - slightly different surface color for elevation
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text/icon color on surface variant
  static const Color onSurfaceVariant = Color(0xFF666666);

  // Surface container - used for cards, search bars, and elevated containers
  static const Color surfaceContainer = Color(0xFFF0F0F0);

  // Text/icon color on surface container
  static const Color onSurfaceContainer = Color(0xFF57531e);

  // Outline color - used for borders and dividers
  static const Color outline = Color(0xFFCCCCCC);

  // Outline variant - lighter outline for subtle borders
  static const Color outlineVariant = Color(0xFFE6E6E6);

  // Tertiary color - additional accent color
  static const Color tertiary = Color(0xFF8B7355);

  // Text/icon color on tertiary background
  static const Color onTertiary = Color(0xFFFFFFFF);

  // Primary container - lighter version of primary for containers
  static const Color primaryContainer = Color(0xFFE8E6D0);

  // Text/icon color on primary container
  static const Color onPrimaryContainer = Color(0xFF57531e);

  // Secondary container - lighter version of secondary for containers
  static const Color secondaryContainer = Color(0xFFF5F3E8);

  // Text/icon color on secondary container
  static const Color onSecondaryContainer = Color(0xFF57531e);

  // Tertiary container - container using tertiary color
  static const Color tertiaryContainer = Color(0xFFE8DCC8);

  // Text/icon color on tertiary container
  static const Color onTertiaryContainer = Color(0xFF8B7355);

  // Text/icon color on error background - ensures readable text on error colored surfaces
  static const Color onError = Color(0xFFFFFFFF);

  // Error container - background for error messages
  static const Color errorContainer = Color(0xFFfee2e2);

  // Text/icon color on error container
  static const Color onErrorContainer = Color(0xFFE53935);

  // ================================================================
  // DARK MODE COLORS
  // ================================================================

  // Primary brand color for dark mode
  static const Color darkPrimary = Color(0xFFedeada);

  // Secondary brand color for dark mode
  static const Color darkSecondary = Color(0xFF57531e);

  // Background color for dark mode
  static const Color darkbackgroundPrimary = Color(0xFF1f1f1f);

  // Primary text color for dark mode
  static const Color darkPrimaryText = Color(0xFFedeada);

  // Text/icon color on primary background in dark mode
  static const Color darkOnPrimary = Color(0xFF1f1f1f);

  // Text/icon color on secondary background in dark mode
  static const Color darkOnSecondary = Color(0xFFedeada);

  // Text/icon color on surface in dark mode
  static const Color darkOnSurface = Color(0xFFedeada);

  // Text/icon color on background in dark mode
  static const Color darkOnBackground = Color(0xFFedeada);

  // Surface variant for dark mode
  static const Color darkSurfaceVariant = Color(0xFF2f2f2f);

  // Text/icon color on surface variant in dark mode
  static const Color darkOnSurfaceVariant = Color(0xFFCCCCCC);

  // Surface container for dark mode - used for cards, search bars, and elevated containers
  static const Color darkSurfaceContainer = Color(0xFF2C2C2C);

  // Text/icon color on surface container in dark mode
  static const Color darkOnSurfaceContainer = Color(0xFFedeada);

  // Outline color for dark mode
  static const Color darkOutline = Color(0xFF666666);

  // Outline variant for dark mode
  static const Color darkOutlineVariant = Color(0xFF444444);

  // Tertiary color for dark mode
  static const Color darkTertiary = Color(0xFFB8A082);

  // Text/icon color on tertiary background in dark mode
  static const Color darkOnTertiary = Color(0xFF1f1f1f);

  // Primary container for dark mode
  static const Color darkPrimaryContainer = Color(0xFF3a3a2a);

  // Text/icon color on primary container in dark mode
  static const Color darkOnPrimaryContainer = Color(0xFFedeada);

  // Secondary container for dark mode
  static const Color darkSecondaryContainer = Color(0xFF2a2a1f);

  // Text/icon color on secondary container in dark mode
  static const Color darkOnSecondaryContainer = Color(0xFFedeada);

  // Tertiary container for dark mode
  static const Color darkTertiaryContainer = Color(0xFF3a3328);

  // Text/icon color on tertiary container in dark mode
  static const Color darkOnTertiaryContainer = Color(0xFFB8A082);

  // Text/icon color on error background in dark mode
  static const Color darkOnError = Color(0xFFFFFFFF);

  // Error container for dark mode
  static const Color darkErrorContainer = Color(0xFF5a1f1f);

  // Text/icon color on error container in dark mode
  static const Color darkOnErrorContainer = Color(0xFFFF6B6B);

  // ================================================================
  // GENERAL COLORS (Shared between themes)
  // ================================================================

  // Error color - used for error states
  static const Color error = Color(0xFFE53935);

  // Error background - light background for error messages
  static const Color errorBg = Color(0xFFfee2e2);
}
