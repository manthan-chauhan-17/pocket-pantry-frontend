import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/feature/item_detail/bloc/item_detail_bloc.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

class ItemDetailScreen extends StatelessWidget {
  final Data item;
  const ItemDetailScreen({super.key, required this.item});

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
      body: BlocListener<ItemDetailBloc, ItemDetailState>(
        listener: (context, state) {
          if (state is DeleteItemSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Item Deleted successfully"),
              ),
            );

            ScreenNavigation.push(context, HomeScreen());
          }

          if (state is DeleteItemErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Something Went Wrong"),
              ),
            );
          }
        },
        child: Container(
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
                  child: Hero(
                    tag: item.sId!,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(
                        16 * getResponsive(context),
                      ),
                      child: Image.network(
                        item.image ?? 'https://picsum.photos/250?image=9',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.03 * getHeight(context)),
              Text(
                item.itemName ?? "Unknown",
                style: TextStyle(
                  fontSize: 24 * getResponsiveText(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
              Text(
                "Category : ${item.category ?? "Unknown"}",
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.015 * getHeight(context)),
              Text(
                "Expiry Date : ${item.expireDate ?? "Unknown"}",
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.015 * getHeight(context)),
              Text(
                "Description : ${item.itemDescription ?? "Unknown"}",
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  log(item.sId!, name: "Item ID");
                  context
                      .read<ItemDetailBloc>()
                      .add(DeleteItemEvent(id: item.sId!));
                  // Add your edit functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
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
                  'Delete',
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
      ),
    );
  }
}
