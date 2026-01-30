import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_button.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';

class AllItemsNoDataState extends StatelessWidget {
  final VoidCallback onAddFirstItem;

  const AllItemsNoDataState({super.key, required this.onAddFirstItem});

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
            /// Empty Illustration
            Container(
              height: Responsive.scaleHeight(140),
              width: Responsive.scaleHeight(140),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(Responsive.scaleHeight(32)),
              ),
              child: Center(
                child: Icon(
                  Icons.kitchen_outlined,
                  size: Responsive.scaleHeight(64),
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),

            SizedBox(height: Responsive.scaleHeight(32)),

            /// Title
            CustomText(
              'Pantry Empty',
              fontSize: Responsive.scaleText(22),
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: Responsive.scaleHeight(12)),

            /// Description
            CustomText(
              "Looks like you haven't added any items yet. "
              "Start tracking your groceries to reduce waste!",
              fontSize: Responsive.scaleText(15),
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurfaceVariant,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),

            SizedBox(height: Responsive.scaleHeight(32)),

            /// CTA Button
            CustomButton.primary(
              text: 'Add First Item',
              onPressed: onAddFirstItem,
              height: Responsive.scaleHeight(54),
              borderRadius: Responsive.scaleHeight(16),
              prefixIcon: Icon(
                Icons.add_circle_outline,
                color: colorScheme.onPrimary,
                size: Responsive.scaleHeight(22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
