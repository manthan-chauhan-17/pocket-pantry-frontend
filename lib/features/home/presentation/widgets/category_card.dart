import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color accentColor;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110, // Fixed height for all cards
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceContainer(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor, size: 24),
          CustomText(
            title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.getOnSurfaceContainer(context),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
