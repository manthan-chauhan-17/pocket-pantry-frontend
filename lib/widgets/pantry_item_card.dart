import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';

class PantryItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String expiry;
  final String itemId;
  const PantryItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.expiry,
    required this.itemId,
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
          Hero(
            tag: itemId,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              // child: Image.network(
              //   imagePath,
              //   height: getHeight(context) * 0.15,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                height: 0.15 * getHeight(context),
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error_rounded),
              ),
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
                    color: AppTheme.getColor(context).onSurface,
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
