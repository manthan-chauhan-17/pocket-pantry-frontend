import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';

class CommonAuthHeader extends StatelessWidget {
  const CommonAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).primaryContainer,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.kitchen,
        size: 50,
        color: AppTheme.getColor(context).primary,
      ),
    );
  }
}
