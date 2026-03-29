import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/features/add_item/presentation/screens/add_item_screen.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/no_data_states/all_items_no_data_state.dart';

class AllItemsSection extends StatefulWidget {
  const AllItemsSection({super.key});

  @override
  State<AllItemsSection> createState() => _AllItemsSectionState();
}

// Grid of Items - All Items
class _AllItemsSectionState extends State<AllItemsSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, GetItemsState>(
      builder: (context, state) {
        // 1. Loading State
        if (state.allItemsLoading) {
          return SizedBox(
            height: 0.28 * Responsive.getHeight(context),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Error State
        if (state.allItemsErrorMessage.isNotEmpty) {
          return SizedBox(
            height: 0.28 * Responsive.getHeight(context),
            child: Center(child: CustomText('Error loading items')),
          );
        }

        // 3. Data Validation
        if (state.getItemsEntity != null) {
          final items = state.getItemsEntity?.items;

          // 4. Empty State
          // If empty, return NoDataState (without "All Items" header)
          if (items?.isEmpty ?? true) {
            return AllItemsNoDataState(
              onAddFirstItem: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddItemScreen(),
                  ),
                );
              },
            );
          }

          // 5. Success State
          // Returns Column with "All Items" Header and Grid
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.generalPadding,
                ),
                child: CustomText(
                  'All Items',
                  fontSize: 20 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onSurface,
                ),
              ),
              SizedBox(height: 0.02 * Responsive.getHeight(context)),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.generalPadding,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    final expires = DateHelper.daysUntilExpiration(expireDate);
                    return _AllItemCard(
                      name: item?.name ?? '',
                      imageUrl: item?.imageUrl ?? '',
                      quantity: item?.quantity?.value.toString() ?? '',
                      expires: expires.toString(),
                      expiresColor: const Color(0xFFFF9500), // Orange
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
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
          // Image
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
              padding: const EdgeInsets.all(Constants.generalPadding),
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
                            '$expires days',
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
