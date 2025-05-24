import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/typography.dart';
import 'package:pocket_pantry_frontend/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data for the grocery items
  final List<Map<String, dynamic>> groceryItems = [
    {
      'image': 'assets/images/apples.png',
      'title': 'Apples',
      'expires': 'May 5, 2024',
      'category': 'Meat',
      'span': 1, // Smaller tile
    },
    {
      'image': 'assets/images/apples.png',
      'title': 'Whole Wheat Bread',
      'expires': 'May 10, 2024',
      'category': 'Bakery',
      'span': 2, // Larger tile
    },
    {
      'image': 'assets/images/apples.png',
      'title': 'Chicken Breast',
      'expires': 'May 5, 2024',
      'category': 'Meat',
      'span': 1,
    },
    {
      'image': 'assets/images/apples.png',
      'title': 'Carrots',
      'expires': '',
      'category': 'Vegetable',
      'span': 1,
    },
    {
      'image': 'assets/images/apples.png',
      'title': 'Greek Yogurt',
      'expires': '',
      'category': '',
      'span': 1,
    },
    {
      'image': 'assets/images/apples.png',
      'title': 'Tomato Sauce',
      'expires': '',
      'category': '',
      'span': 1,
    },
  ];

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
        shadowColor: AppColors.shadow,
      ),
      body: GridView.builder(
        itemCount: groceryItems.length,
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          return GroceryTile(
            image: item['image'],
            title: item['title'],
            expires: item['expires'],
            category: item['category'],
          );
        },
      ),
    );
  }
}

class GroceryTile extends StatelessWidget {
  final String image;
  final String title;
  final String expires;
  final String category;

  const GroceryTile({
    required this.image,
    required this.title,
    required this.expires,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.getLightTextTheme(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.lightSurface,
      shadowColor: AppColors.shadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.divider,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.lightIcon,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                if (expires.isNotEmpty)
                  Text(
                    'Expires: $expires',
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.lightText.withOpacity(0.7),
                    ),
                  ),
                if (category.isNotEmpty)
                  Text(
                    category,
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
