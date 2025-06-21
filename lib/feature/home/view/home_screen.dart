import 'dart:io';
import 'package:flutter/cupertino.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/add_item/view/add_item.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_event.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_state.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart'
    hide Image;
import 'package:pocket_pantry_frontend/feature/item_detail/view/item_detail_screen.dart';
import 'package:pocket_pantry_frontend/feature/profile/view/profile_screen.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_helper/hive_helper.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_model/hive_item_model.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';
import 'package:pocket_pantry_frontend/widgets/pantry_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(GetItemEvent());
  }

  List<HiveItemModel> hiveItemList = [];
  String userName = "";
  // void loadUsername() async {
  //   userName = await MySharedPreference.getUserName();
  // }

  void loadHiveDataAfterBloc(List<Item> items) async {
    hiveItemList = await HiveItemHelper.getAllItems();
    // log(hiveItemList.toString(), name: "HIVE_ITEM_LIST");
    userName = await MySharedPreference.getUserName();
    setState(() {}); // rebuild with updated data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pocket Pantry',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20 * getResponsiveText(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScreenNavigation.push(context, AddItemScreen());
            },
            icon: Icon(
              Icons.add,
            ),
          ),
          GestureDetector(
            onTap: () {
              ScreenNavigation.push(context, ProfileScreen());
            },
            child: Container(
              margin: EdgeInsets.only(right: 0.05 * getWidth(context)),
              height: 0.1 * getHeight(context),
              width: 0.1 * getWidth(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/images/profile_pic.png"),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetItemsLoadingState) {
            return Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            );
          }

          if (state is GetItemsSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              loadHiveDataAfterBloc(state.items);
            });
            // List<Item> items = state.items;

            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: getWidth(context) * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back, $userName"),
                  SizedBox(height: getHeight(context) * 0.02),
                  // Dropdown
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.03),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLightBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: 'ALL',
                      // isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      items: const [
                        DropdownMenuItem(value: 'ALL', child: Text('ALL')),
                      ],
                      onChanged: (value) {},
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16 * getResponsiveText(context),
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(context) * 0.02),
                  // Grid of pantry items
                  Expanded(
                    child: GridView.builder(
                      itemCount: hiveItemList.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 240 * getResponsive(context),
                      ),
                      itemBuilder: (context, index) {
                        final item = hiveItemList[index];
                        return GestureDetector(
                          onTap: () {
                            ScreenNavigation.push(
                                context,
                                ItemDetailScreen(
                                  item: item,
                                ));
                          },
                          child: PantryItemCard(
                            imagePath: item.imageUrl,
                            title: item.itemName,
                            expiry: 'Expires on ${item.expireDate}',
                            itemId: item.id,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
          if (state is GetItemsErrorState) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          return Center(
            child: Text("No Item Found , Add items by clicking + icon"),
          );
        },
      ),
    );
  }
}
