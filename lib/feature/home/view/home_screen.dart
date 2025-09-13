import 'dart:io';
import 'package:flutter/cupertino.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/add-item/view/add_item_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_event.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_state.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart'
    hide Image;
import 'package:pocket_pantry_frontend/feature/item-detail/view/item_detail_screen.dart';
import 'package:pocket_pantry_frontend/feature/profile/view/profile_screen.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/utils/date_helper.dart';
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

  String userName = "";

  void loadHiveDataAfterBloc(List<Items> items) async {
    userName = await MySharedPreference.getUserName();
    setState(() {}); // rebuild with updated data
  }

  final List<String> categories = [
    "Vegetables",
    "Fruits",
    "Dairy",
    "Grains",
    "Spices",
    "Beverages",
    "Snacks",
    "Frozen",
    "Others"
  ];

  String selectedCategory = '';

  void _showCategoryDropdown() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16 * getResponsive(context)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Category',
                    style: TextStyle(
                      fontSize: 16 * getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: AppTheme.getColor(context).onSurface,
                      ))
                ],
              ),
              SizedBox(height: 16 * getResponsive(context)),
              ...categories
                  .map((category) => ListTile(
                        title: Text(category),
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                          Navigator.pop(context);
                        },
                        trailing: selectedCategory == category
                            ? Icon(Icons.check, color: Color(0xFF7CB342))
                            : null,
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.getColor(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.getColor(context).surface,
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
            onPressed: () async {
              // ✅ Navigate to AddItemScreen and wait for result
              // If result is true, it means an item was successfully added
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemScreen()),
              );

              // ✅ If item was successfully added, refresh the home screen data
              if (result == true) {
                // Trigger a refresh of items by dispatching GetItemEvent
                context.read<HomeBloc>().add(GetItemEvent());
              }
            },
            icon: Icon(
              Icons.add,
              color: AppTheme.getColor(context).onSurface,
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

            return RefreshIndicator(
              // ✅ Add pull-to-refresh functionality for better user experience
              onRefresh: () async {
                // Trigger a refresh of items when user pulls down
                context.read<HomeBloc>().add(GetItemEvent());
                // Wait a bit to show the refresh indicator
                await Future.delayed(Duration(milliseconds: 500));
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(context) * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back, $userName"),
                    SizedBox(height: getHeight(context) * 0.02),
                    // Category Field
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03 * getWidth(context)),
                      child: GestureDetector(
                        onTap: _showCategoryDropdown,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.getColor(context).onSurfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18 * getResponsive(context),
                            vertical: 20 * getResponsive(context),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCategory.isEmpty
                                    ? 'All'
                                    : selectedCategory,
                                style: TextStyle(
                                  color: selectedCategory.isEmpty
                                      ? AppTheme.getColor(context).onSurface
                                      : Colors.black,
                                  fontSize: 18 * getResponsiveText(context),
                                ),
                              ),
                              Transform.rotate(
                                angle: 1.5708, // 90 degrees in radians
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFF8BC34A),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: getHeight(context) * 0.02),
                    // Grid of pantry items
                    Expanded(
                      child: GridView.builder(
                        itemCount: state.items.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 240 * getResponsive(context),
                        ),
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          // final expireDate =
                          //     DateHelper.timestampToString(item.expireDate);
                          return GestureDetector(
                            onTap: () {
                              ScreenNavigation.push(
                                  context,
                                  ItemDetailScreen(
                                    itemId: item.id ?? '',
                                  ));
                            },
                            child: PantryItemCard(
                              imagePath: item.image?.url ?? '',
                              title: item.itemName ?? '',
                              expiry:
                                  'Expires on ${DateHelper.timestampToString(item.expireDate ?? -1).split(',')[0]}',
                              itemId: item.id ?? '',
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
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
