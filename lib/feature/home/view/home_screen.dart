import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_event.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_state.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
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
    // context.read<ItemBloc>().add(GetItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pocket Pantry"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: AppColors.darkBackground,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0 * getResponsive(context)),
        child: Column(),
      ),
    );
  }
}
