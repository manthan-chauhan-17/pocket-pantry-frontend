import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/item-detail/bloc/item_detail_bloc.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemId;
  const ItemDetailScreen({super.key, required this.itemId});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(loadData);
  }

  void loadData() async {
    context
        .read<ItemDetailBloc>()
        .add(GetItemDetailEvent(itemId: widget.itemId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.getColor(context).surface,
        leading: BackButton(),
        title: Text("Item Details"),
        centerTitle: true,
      ),
      body: BlocConsumer<ItemDetailBloc, ItemDetailState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GetItemDetailLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetItemDetailErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is GetITemDEtailSuccessState) {
            final item = state.itemModel.item;
            return Container(
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
                        tag: 'id',
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(
                            16 * getResponsive(context),
                          ),
                          child: Image.network(
                            item?.image?.url ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ReusableWidgets.getSizedBox(
                      height: 0.03 * getHeight(context)),
                  Text(
                    item?.itemName ?? '',
                    style: TextStyle(
                      fontSize: 24 * getResponsiveText(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ReusableWidgets.getSizedBox(
                      height: 0.02 * getHeight(context)),
                  Text(
                    "Category : ${item?.category ?? ''}",
                    style: TextStyle(
                      fontSize: 18 * getResponsiveText(context),
                    ),
                  ),
                  ReusableWidgets.getSizedBox(
                      height: 0.015 * getHeight(context)),
                  Text(
                    "Expiry Date : ${DateHelper.timestampToString(item?.expireDate ?? -1)}",
                    style: TextStyle(
                      fontSize: 18 * getResponsiveText(context),
                    ),
                  ),
                  ReusableWidgets.getSizedBox(
                      height: 0.015 * getHeight(context)),
                  Text(
                    "Description : ${item?.itemDescription ?? ''}",
                    style: TextStyle(
                      fontSize: 18 * getResponsiveText(context),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // log(item.id, name: "Item ID");
                      // context
                      //     .read<ItemDetailBloc>()
                      //     .add(DeleteItemEvent(id: item.id));
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
                      minimumSize: Size(
                          0.9 * getWidth(context), 0.04 * getHeight(context)),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 18 * getResponsiveText(context),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ReusableWidgets.getSizedBox(
                      height: 0.02 * getHeight(context)),
                ],
              ),
            );
          }
          return Center(child: Text("Something Went Wrong"));
        },
      ),
    );
  }
}
