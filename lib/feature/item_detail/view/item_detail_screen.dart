import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/feature/item_detail/bloc/item_detail_bloc.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_model/hive_item_model.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

class ItemDetailScreen extends StatelessWidget {
  final HiveItemModel item;
  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.getColor(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.getColor(context).surface,
        leading: BackButton(),
        title: Text("Item Details"),
        centerTitle: true,
      ),
      body: BlocListener<ItemDetailBloc, ItemDetailState>(
        listener: (context, state) {
          if (state is DeleteItemSuccessState) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Success",
                message: "Item Deleted Successfully",
                contentType: ContentType.success);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);

            ScreenNavigation.push(context, HomeScreen());
          }

          if (state is DeleteItemErrorState) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Error",
                message: "Something went wrong",
                contentType: ContentType.failure);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                    tag: item.id,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(
                        16 * getResponsive(context),
                      ),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.03 * getHeight(context)),
              Text(
                item.itemName,
                style: TextStyle(
                  fontSize: 24 * getResponsiveText(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
              Text(
                "Category : ${item.category}",
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.015 * getHeight(context)),
              Text(
                "Expiry Date : ${item.expireDate}",
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.015 * getHeight(context)),
              Text(
                "Description : ${item.itemDescription}",
                style: TextStyle(
                  fontSize: 18 * getResponsiveText(context),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  log(item.id, name: "Item ID");
                  context
                      .read<ItemDetailBloc>()
                      .add(DeleteItemEvent(id: item.id));
                  // Add your edit functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.getColor(context).error,
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
