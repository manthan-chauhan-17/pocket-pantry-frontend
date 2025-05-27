import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_event.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_state.dart';
import 'package:pocket_pantry_frontend/typography.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/widgets/grocery_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(GetItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pocket Pantry',
          style: AppTextTheme.getLightTextTheme(context).headlineLarge,
        ),
        backgroundColor: AppColors.lightSurface,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetItemsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetItemsSuccessState) {
            var itemState = state;

            return GridView.builder(
              itemCount: itemState.items.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final item = itemState.items[index];
                return GroceryTile(
                  image: item.image ??
                      "http://res.cloudinary.com/dbh5as7t7/image/upload/v1747547965/sqw45zyb5dcqzbcrvt5x.jpg",
                  title: item.itemName!,
                  expires: item.expireDate!,
                  category: item.category!,
                );
              },
            );
          }
          return Center(
            child: Text("No Data Found"),
          );
        },
      ),
    );
  }
}
