import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.borderRadius = Constants.borderRadius,
    this.isSuffixIconOn = false,
    this.suffixIcon,
    this.suffixIconColor,
    this.isPrefixIconOn = false,
    this.prefixIcon,
    this.prefixIconColor,
    this.fillColor,
    this.validator,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final double borderRadius;
  final bool isSuffixIconOn;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final bool isPrefixIconOn;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: AppTheme.getColor(context).primary),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: TextStyle(color: AppTheme.getColor(context).primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppTheme.getColor(context).primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppTheme.getColor(context).primary),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppTheme.getColor(context).primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppTheme.getColor(context).error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppTheme.getColor(context).error),
        ),
        suffixIcon: isSuffixIconOn ? suffixIcon : null,
        suffixIconColor: suffixIconColor ?? AppTheme.getColor(context).primary,
        prefixIcon: isPrefixIconOn ? prefixIcon : null,
        prefixIconColor: prefixIconColor ?? AppTheme.getColor(context).primary,
        fillColor: fillColor ?? AppTheme.getColor(context).surfaceContainer,
        filled: true,
      ),
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required!';
            }
            return null;
          },
    );
  }
}
