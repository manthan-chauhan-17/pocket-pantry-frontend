import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/item_card.dart';

class HorizontalItemList extends StatelessWidget {
  final int itemCount;
  final double? height;

  const HorizontalItemList({super.key, this.itemCount = 5, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0.28 * Responsive.getHeight(context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Constant.generalPadding,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 12),
            child: ItemCard(),
          );
        },
      ),
    );
  }
}
