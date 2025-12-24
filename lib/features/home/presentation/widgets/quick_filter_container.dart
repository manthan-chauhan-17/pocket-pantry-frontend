import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class QuickFilterContainer extends StatelessWidget {
  const QuickFilterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.29 * Responsive.getWidth(context),
      height: 0.15 * Responsive.getHeight(context),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(color: AppTheme.getColor(context).primary),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Icon(CupertinoIcons.clock),
          // Text
          CustomText('Expiring Soon', fontSize: 16.0),
        ],
      ),
    );
  }
}
