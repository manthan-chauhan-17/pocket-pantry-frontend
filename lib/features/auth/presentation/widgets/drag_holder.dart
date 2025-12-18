import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';

class DragHolder extends StatelessWidget {
  const DragHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).primary,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
    );
  }
}
