import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_button.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';

class ExpiringSoonAllClearState extends StatelessWidget {
  final VoidCallback onViewAllItems;

  const ExpiringSoonAllClearState({super.key, required this.onViewAllItems});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final colorScheme = AppTheme.getColor(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Success Circle with Glow
            Container(
              height: Responsive.scaleHeight(160),
              width: Responsive.scaleHeight(160),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colorScheme.primary.withOpacity(0.35),
                    Colors.transparent,
                  ],
                  radius: 0.8,
                ),
              ),
              child: Center(
                child: Container(
                  height: Responsive.scaleHeight(96),
                  width: Responsive.scaleHeight(96),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: Responsive.scaleHeight(44),
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: Responsive.scaleHeight(28)),

            /// Title
            CustomText(
              'All Clear!',
              fontSize: Responsive.scaleText(22),
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: Responsive.scaleHeight(10)),

            /// Description
            CustomText(
              'Great job! You have no items expiring soon. '
              'Your pantry is fresh and healthy.',
              fontSize: Responsive.scaleText(15),
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurfaceVariant,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),

            SizedBox(height: Responsive.scaleHeight(28)),

            /// CTA Button
            CustomButton.outlined(
              text: 'View All Expiring Items',
              onPressed: onViewAllItems,
              height: Responsive.scaleHeight(48),
              borderRadius: Responsive.scaleHeight(14),
              borderColor: colorScheme.outline,
              prefixIcon: Icon(
                Icons.inventory_2_outlined,
                size: Responsive.scaleHeight(20),
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
