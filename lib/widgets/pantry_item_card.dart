import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/responsive.dart';

class PantryItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String expiry;

  const PantryItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              imagePath,
              height: getHeight(context) * 0.15,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(getWidth(context) * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16 * getResponsiveText(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getHeight(context) * 0.005),
                Text(
                  expiry,
                  style: TextStyle(
                    fontSize: 14 * getResponsiveText(context),
                    color: AppColors.greenText,
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
