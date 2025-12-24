import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/category_cards_row.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/home_header.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/home_search_bar.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/horizontal_item_list.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/item_grid.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/section_header.dart';

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
  }

  void _handleNotificationPressed() {
    // Handle notification
  }

  void _handleAddPressed() {
    // Handle add action
  }

  void _handleSeeAllExpiringSoon() {
    // Handle see all expiring soon
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              HomeHeader(
                greetingMessage: greetingMessage,
                userName: userName,
                onNotificationPressed: _handleNotificationPressed,
                onAddPressed: _handleAddPressed,
              ),

              const SizedBox(height: 20),

              // Search Bar
              HomeSearchBar(controller: searchController),

              const SizedBox(height: 20),

              // Category Overview Cards
              const CategoryCardsRow(),

              const SizedBox(height: 24),

              // Expiring Soon Section
              SectionHeader(
                title: 'Expiring Soon',
                seeAllText: 'See All',
                onSeeAllPressed: _handleSeeAllExpiringSoon,
              ),

              const SizedBox(height: 12),

              // Horizontal Scrollable Items
              const HorizontalItemList(),

              const SizedBox(height: 24),

              // All Items Section
              SectionHeader(title: 'All Items'),

              const SizedBox(height: 12),

              // Grid of Items
              const ItemGrid(),

              const SizedBox(height: 20),
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
