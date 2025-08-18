import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';

enum FieldType { name, email, password, description }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FieldType fieldType;
  final String? labelText;
  final String? Function(String?) validator;
  final IconData? suffixIcon;
  final int? line;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxlines;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.fieldType,
    this.labelText,
    required this.validator,
    this.suffixIcon,
    this.line,
    this.keyboardType,
    this.hintText,
    this.maxlines,
    this.onTap,
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

    return Padding(
      padding: EdgeInsets.all(12 * getResponsive(context)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0 * getResponsive(context)),
        ),
        child: TextFormField(
          onTap: widget.onTap,
          controller: widget.controller,
          textAlign: TextAlign.start,
          textAlignVertical:
              TextAlignVertical.top, // 🔹 Start text from the top vertically
          keyboardType: _getKeyboardType(), // 🔹 Allow multiline input
          maxLines: widget.maxlines, // 🔹 Unlimited lines
          minLines: widget.line ??
              1, // 🔹 Field height - start with 5 lines worth of space

          obscureText: widget.fieldType == FieldType.password && _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText ?? "",
            labelText: widget.labelText,
            labelStyle: textTheme.bodyMedium,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(12.0 * getResponsive(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppTheme.getColor(context).onPrimary,
            suffixIcon: _buildSuffixIcon(),
          ),
          validator: widget.validator,
        ),
      ),
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
      case FieldType.description:
        return TextInputType.multiline; // 🔹 For multiline description
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.fieldType == FieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.darkPrimary,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.suffixIcon != null) {
      // 💡 You can optionally pass a suffixIcon from the widget
      return Icon(widget.suffixIcon,
          color: AppTheme.getColor(context).onSurface);
    } else {
      return null;
    }
  }
}
