import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pantry_frontend/responsive.dart';

class AppTextTheme {
  static TextTheme getLightTextTheme(BuildContext context) {
    final scale = getResponsiveText(context);

    return TextTheme(
      // for large headings
      // e.g. for titles, large headings
      displayLarge: GoogleFonts.poppins(
        fontSize: 32 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24 * scale,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20 * scale,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18 * scale,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      // for body text
      // e.g. for paragraphs, body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16 * scale,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14 * scale,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
      // for labels
      // e.g. for buttons, labels
      // e.g. for captions, small text
      labelLarge: GoogleFonts.sora(
        fontSize: 12 * scale,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }

  static TextTheme getDarkTextTheme(BuildContext context) {
    final scale = getResponsiveText(context);

    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24 * scale,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20 * scale,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18 * scale,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16 * scale,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14 * scale,
        fontWeight: FontWeight.normal,
        color: Colors.white60,
      ),
      labelLarge: GoogleFonts.sora(
        fontSize: 12 * scale,
        fontWeight: FontWeight.w500,
        color: Colors.white60,
      ),
    );
  }
}
