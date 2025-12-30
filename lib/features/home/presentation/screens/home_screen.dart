import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/router/route_paths.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/category_cards_row.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/home_header.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/home_search_bar.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/no_expiring_soon_items_found.dart';

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
    context.read<HomeBloc>().add(GetItemsEvent());
  }

  void _handleNotificationPressed() {
    // Handle notification
  }

  void _handleAddPressed() {
    // Handle add action
    context.pushNamed(RoutePaths.addItem);
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

              // NoExpiringSoonItemsFound(),

              // Expiring Soon Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constant.generalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Expiring Soon',
                      fontSize: 20 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                      // color: AppTheme.getColor(context).onSurface,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle see all expiring soon
                      },
                      child: CustomText(
                        'See All',
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFFFD700),
                        color: Color(
                          0xFFFFD700,
                        ), // Yellow/Gold - works for both themes
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Scrollable Items - Expiring Soon
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is GetItemsLoadingState) {
                    return SizedBox(
                      height: 0.28 * Responsive.getHeight(context),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is GetItemsErrorState) {
                    return SizedBox(
                      height: 0.28 * Responsive.getHeight(context),
                      child: Center(child: CustomText('Error loading items')),
                    );
                  }

                  if (state is GetItemsSuccessState) {
                    final items = state.getItemsEntity.items;

                    if (items?.isEmpty ?? true) {
                      return SizedBox(
                        height: 0.28 * Responsive.getHeight(context),
                        child: Center(child: CustomText('No items found')),
                      );
                    }
                    return SizedBox(
                      height: 0.28 * Responsive.getHeight(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constant.generalPadding,
                        ),
                        itemCount: items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = items?[index];
                          final expireDate = DateHelper.timestampToDateTime(
                            item?.expireDate ?? 0,
                          );
                          final expires = DateHelper.daysUntilExpiration(
                            expireDate,
                          );
                          return Padding(
                            padding: EdgeInsets.only(
                              right: Constant.generalPadding,
                            ),
                            child: _ExpiringItemCard(
                              name: item?.itemName ?? '',
                              imageUrl: item?.image?.url ?? '',
                              quantity: '',
                              expires: '${3} days',
                              // tag: item.,
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              // All Items Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constant.generalPadding,
                ),
                child: CustomText(
                  'All Items',
                  fontSize: 20 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onBackground,
                ),
              ),

              // Grid of Items - All Items
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is GetItemsLoadingState) {
                    return SizedBox(
                      height: 0.28 * Responsive.getHeight(context),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is GetItemsErrorState) {
                    return SizedBox(
                      height: 0.28 * Responsive.getHeight(context),
                      child: Center(child: CustomText('Error loading items')),
                    );
                  }

                  if (state is GetItemsSuccessState) {
                    final items = state.getItemsEntity.items;

                    if (items?.isEmpty ?? true) {
                      return SizedBox(
                        height: 0.28 * Responsive.getHeight(context),
                        child: Center(child: CustomText('No items found')),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constant.generalPadding,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items?.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          final item = items?[index];
                          final expireDate = DateHelper.timestampToDateTime(
                            item?.expireDate ?? 0,
                          );
                          final expires = DateHelper.daysUntilExpiration(
                            expireDate,
                          );
                          return _AllItemCard(
                            name: item?.itemName ?? '',
                            imageUrl: item?.image?.url ?? '',
                            quantity: '',
                            expires: '${3} days',
                            expiresColor: const Color(0xFFFF9500), // Orange
                            // tag: item?.itemTag,
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpiringItemCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String quantity;
  final String expires;

  const _ExpiringItemCard({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.expires,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4 * Responsive.getWidth(context),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceContainer(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with optional tag
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 0.15 * Responsive.getHeight(context),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.getColor(context).surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme.getColor(context).surfaceContainerHighest,
                child: Icon(
                  Icons.error,
                  color: AppTheme.getColor(context).onSurfaceVariant,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(Constant.generalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  name,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onSurface,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Quantity',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.getColor(context).onSurfaceVariant,
                        ),
                        const SizedBox(height: 2),
                        CustomText(
                          quantity,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.getColor(context).onSurface,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          'Expires',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.getColor(context).onSurfaceVariant,
                        ),
                        const SizedBox(height: 2),
                        CustomText(
                          expires,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(
                            0xFFFF3B30,
                          ), // Red for expiring soon
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// All Items Card (Grid)
class _AllItemCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String quantity;
  final String expires;
  final Color expiresColor;

  const _AllItemCard({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.expires,
    required this.expiresColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceContainer(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with optional tag
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 0.15 * Responsive.getHeight(context),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.getColor(context).surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme.getColor(context).surfaceContainerHighest,
                child: Icon(
                  Icons.error,
                  color: AppTheme.getColor(context).onSurfaceVariant,
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Constant.generalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    name,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getColor(context).onSurface,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Quantity',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.getColor(context).onSurfaceVariant,
                          ),
                          const SizedBox(height: 2),
                          CustomText(
                            quantity,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.getColor(context).onSurface,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            'Expires',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.getColor(context).onSurfaceVariant,
                          ),
                          const SizedBox(height: 2),
                          CustomText(
                            expires,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: expiresColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
