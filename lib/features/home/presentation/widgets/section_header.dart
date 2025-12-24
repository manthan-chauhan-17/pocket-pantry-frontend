import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? seeAllText;
  final VoidCallback? onSeeAllPressed;
  final Color? seeAllColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.seeAllText,
    this.onSeeAllPressed,
    this.seeAllColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constant.generalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.getColor(context).onBackground,
          ),
          if (seeAllText != null)
            GestureDetector(
              onTap: onSeeAllPressed,
              child: CustomText(
                seeAllText!,
                fontSize: 14,
                color:
                    seeAllColor ??
                    const Color(
                      0xFFFFD700,
                    ), // Yellow/Gold - works for both themes
              ),
            ),
        ],
      ),
    );
  }
}
