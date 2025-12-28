import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/category_card.dart';

class CategoryCardsRow extends StatelessWidget {
  const CategoryCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constant.generalPadding),
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: CategoryCard(
              title: 'Expiring Soon',
              icon: CupertinoIcons.clock,
              iconColor: const Color(0xFFFF3B30), // Red - works for both themes
              accentColor: const Color(0xFFFF3B30),
            ),
          ),
          Expanded(
            child: CategoryCard(
              title: 'Low Stock',
              icon: CupertinoIcons.arrow_down_square,
              iconColor: const Color(
                0xFFFF9500,
              ), // Orange - works for both themes
              accentColor: const Color(0xFFFF9500),
            ),
          ),
          Expanded(
            child: CategoryCard(
              title: 'Recently Added',
              icon: CupertinoIcons.plus_square,
              iconColor: const Color(
                0xFFFFD700,
              ), // Yellow/Gold - works for both themes
              accentColor: const Color(0xFFFFD700),
            ),
          ),
        ],
      ),
    );
  }
}
