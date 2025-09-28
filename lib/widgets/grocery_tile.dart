import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';

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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
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
                Text(title,
                    style: TextStyle(
                      fontSize: 18 * getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getColor(context).primary,
                    )),
                if (expires.isNotEmpty)
                  Text('Expires: $expires',
                      style: TextStyle(
                          fontSize: 12 * getResponsiveText(context),
                          fontWeight: FontWeight.w500,
                          color: Colors.white60)),
                if (category.isNotEmpty)
                  Text(category,
                      style: TextStyle(
                        fontSize: 12 * getResponsiveText(context),
                        fontWeight: FontWeight.w500,
                        color: AppTheme.getColor(context).primary,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
