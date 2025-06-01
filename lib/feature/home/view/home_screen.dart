import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/add_item/view/add_item.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/login_screen.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_event.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_state.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/widgets/pantry_item_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List screens = [
    const PantryScreen(),
    // To be replaced with SettingsScreen
    const RegisterScreen(),
    // To be replaced with ProfileScreen
    const LoginScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is NavigationState) {
          currentIndex = state.currentIndex;
        }
      },
      builder: (context, state) {
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
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context) * 0.04,
                    vertical: getHeight(context) * 0.01,
                  ),
                  child: IconButton(
                    onPressed: () {
                      ScreenNavigation.push(context, AddItemScreen());
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  )),
            ],
          ),
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedItemColor: AppColors.darkBackground,
            unselectedItemColor: Colors.grey,
            backgroundColor: AppColors.lightBackground,
            onTap: (value) {
              context.read<HomeBloc>().add(
                    BottomNavBarTappedEvent(index: value),
                  );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Pantry',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetItemsLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.darkBackground,
            ),
          );
        } else if (state is GetItemsErrorState) {
          return Center(
            child: Text(
              'Error fetching items',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16 * getResponsiveText(context),
              ),
            ),
          );
        } else if (state is GetItemsSuccessState) {
          final items = state.items;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
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
                    itemCount: items.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return PantryItemCard(
                        imagePath:
                            item.image ?? 'https://picsum.photos/250?image=9',
                        title: item.itemName ?? 'Unknown Item',
                        expiry: item.expireDate != null
                            ? 'Expires on ${item.expireDate}'
                            : 'No expiry date',
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              'No items found',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16 * getResponsiveText(context),
              ),
            ),
          );
        }
      },
    );
  }
}
