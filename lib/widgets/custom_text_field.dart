import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';

enum FieldType { name, email, password }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FieldType fieldType;
  final String labelText;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.fieldType,
    required this.labelText,
    required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.fieldType == FieldType.password && _obscureText,
      keyboardType: _getKeyboardType(),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: AppColors.lightSurface,
        suffixIcon: widget.fieldType == FieldType.password
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.lightIcon,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: widget.validator,
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.name:
        return TextInputType.name;
      case FieldType.password:
        return TextInputType.visiblePassword;
    }
  }
}
