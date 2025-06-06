import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        leading: BackButton(),
        title: Text("Item Details"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 0.016 * getHeight(context),
          horizontal: 0.05 * getWidth(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 0.45 * getHeight(context),
                width: 0.9 * getWidth(context),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(
                    16 * getResponsive(context),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(
                    16 * getResponsive(context),
                  ),
                  child: Image.asset(
                    "assets/images/apple.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ReusableWidgets.getSizedBox(height: 0.03 * getHeight(context)),
            Text(
              "Organic Apple",
              style: TextStyle(
                fontSize: 24 * getResponsiveText(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
            Text(
              "Category : Fruits",
              style: TextStyle(
                fontSize: 18 * getResponsiveText(context),
              ),
            ),
            ReusableWidgets.getSizedBox(height: 0.015 * getHeight(context)),
            Text(
              "Expiry Date : 05/05/2025",
              style: TextStyle(
                fontSize: 18 * getResponsiveText(context),
              ),
            ),
            ReusableWidgets.getSizedBox(height: 0.015 * getHeight(context)),
            Text(
              "Description : Freshly picked organic apples from local farm. Store in a cool, dry place.",
              style: TextStyle(
                fontSize: 18 * getResponsiveText(context),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Add your edit functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenTextField,
                padding: EdgeInsets.symmetric(
                  vertical: 0.015 * getHeight(context),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                minimumSize:
                    Size(0.9 * getWidth(context), 0.04 * getHeight(context)),
              ),
              child: Text(
                'Edit',
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                  color: Colors.black,
                ),
              ),
            ),
            ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
          ],
        ),
      ),
    );
  }
}
