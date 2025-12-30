import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class NoExpiringSoonItemsFound extends StatelessWidget {
  const NoExpiringSoonItemsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.28 * Responsive.getHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Some Image
          CustomText(
            'All Clear!',
            fontSize: 20 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: AppTheme.getColor(context).onSurface,
          ),
          SizedBox(height: 0.01 * Responsive.getHeight(context)),
          CustomText(
            'Great Job! , You have no items expiring soon. Your pantry is looking good!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
