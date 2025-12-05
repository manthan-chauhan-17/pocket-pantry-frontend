import 'package:flutter/material.dart';

/// A custom text widget that supports optional language translation,
/// styling, keyword highlighting, and a required field indicator.
class CustomText extends StatelessWidget {
  final String text; // The main text to display.
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final FontStyle? fontStyle;

  // Highlighting options
  final bool isHighlight; // Whether to enable highlighting.
  final String? highlightText; // The substring to highlight.
  final bool isUpperCase; // Whether to convert the text to uppercase.
  final Color?
  highlightBackgroundColor; // Background color of highlighted text.

  // Required field indicator
  final bool
  isRequired; // If true, displays a red asterisk (*) next to the text.

  final List<Shadow> textShadows; // Optional text shadows.

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.decorationColor,
    this.fontStyle,
    this.isHighlight = false,
    this.highlightText,
    this.isUpperCase = false,
    this.highlightBackgroundColor,
    this.isRequired = false, // Defaults to false
    this.textShadows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        fontStyle: fontStyle,
        shadows: textShadows,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
