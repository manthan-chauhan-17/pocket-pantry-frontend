import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/category_cards_row.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/home_header.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String userName = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String get greetingMessage {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(fetchInitialData);
  }

  void fetchInitialData() async {
    final name = await PreferenceService.getUserName();
    if (mounted) {
      setState(() {
        userName = name.isNotEmpty ? name : 'Sarah';
      });
    }
    // context.read<HomeBloc>().add(GetItemsEvent());
  }

  void _handleNotificationPressed() {
    // Handle notification
  }

  void _handleAddPressed() {
    // Handle add action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              HomeHeader(
                greetingMessage: greetingMessage,
                userName: userName,
                onNotificationPressed: _handleNotificationPressed,
                onAddPressed: _handleAddPressed,
              ),

              // Search Bar
              HomeSearchBar(controller: searchController),

              // Category Overview Cards
              const CategoryCardsRow(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Color Palette (from design):
- Primary Dark Background: #1A1A1A
- Card Background / Search Bar Background: #2C2C2C
- Text (Primary White): #FFFFFF
- Text (Secondary Light Gray / Placeholder): #AAAAAA
- Accent Color (Yellow/Gold): #FFD700
- Accent Color (Red): #FF3B30
- Accent Color (Orange): #FF9500
- Accent Color (Green): #34C759
- Notification Bell Icon: #333333 (background)
- Icon (Filter/Sort, Search): #AAAAAA
*/
