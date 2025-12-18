import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';

class SuffixEyeIcon extends StatelessWidget {
  const SuffixEyeIcon({
    super.key,
    required this.confirmPasswordController,
    required this.onPressed,
    required this.isVisible,
  });

  final TextEditingController confirmPasswordController;
  final VoidCallback onPressed;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
      color: AppTheme.getColor(context).primary,
    );
  }
}
