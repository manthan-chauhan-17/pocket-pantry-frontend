import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/typography.dart';

class GroceryTile extends StatelessWidget {
  final String image;
  final String title;
  final String expires;
  final String category;

  const GroceryTile({
    super.key,
    required this.image,
    required this.title,
    required this.expires,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.getLightTextTheme(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.lightSurface,
      shadowColor: AppColors.shadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.divider,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.lightIcon,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                if (expires.isNotEmpty)
                  Text(
                    'Expires: $expires',
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.lightText.withOpacity(0.7),
                    ),
                  ),
                if (category.isNotEmpty)
                  Text(
                    category,
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
