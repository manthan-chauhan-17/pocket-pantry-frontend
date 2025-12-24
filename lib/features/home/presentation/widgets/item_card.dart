import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Constant.generalPadding / 2),
      width: 0.4 * Responsive.getWidth(context),
      padding: EdgeInsets.all(Constant.generalPadding),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl:
                  'http://res.cloudinary.com/dbh5as7t7/image/upload/v1759379935/tgy1uwstqnako9mhvkbo.jpg',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 0.15 * Responsive.getHeight(context),
              width: 0.3 * Responsive.getWidth(context),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          CustomText('Item Name'),
          SizedBox(height: 8),
          CustomText('Exp : 12/12/2023', fontSize: 12),
        ],
      ),
    );
  }
}
