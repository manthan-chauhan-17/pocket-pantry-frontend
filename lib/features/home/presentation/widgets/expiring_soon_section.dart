import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/widgets/no_data_states/expiring_soon_all_clear_state.dart';

class ExpiringSoonSection extends StatelessWidget {
  const ExpiringSoonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, GetItemsState>(
      builder: (context, state) {
        // 1. Loading State
        if (state.expiringSoonLoading) {
          return SizedBox(
            height: 0.28 * Responsive.getHeight(context),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Error State
        if (state.expiringSoonErrorMessage.isNotEmpty) {
          return SizedBox(
            height: 0.28 * Responsive.getHeight(context),
            child: Center(child: CustomText('Error loading items')),
          );
        }

        final expiringSoonItems = state.getExpiringSoonItemsEntity?.items;

        // 3. Empty State (Hide Section Completely)
        // If list is empty (or null), we return SizedBox.shrink() to hide the widget
        // effectively handling "No Expiring soon items widget" requirement.
        if (expiringSoonItems?.isEmpty ?? true) {
          return ExpiringSoonAllClearState(onViewAllItems: () {});
        }

        // 4. Success State (Show Header + List)
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.generalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Expiring Soon',
                    fontSize: 20 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle see all expiring soon
                    },
                    child: CustomText(
                      'See All',
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFFFD700),
                      color: const Color(0xFFFFD700), // Yellow/Gold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.28 * Responsive.getHeight(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.generalPadding,
                ),
                itemCount: expiringSoonItems?.length ?? 0,
                itemBuilder: (context, index) {
                  final expiringSoonItem = expiringSoonItems?[index];
                  final expireDate = DateHelper.timestampToDateTime(
                    expiringSoonItem?.expireDate ?? 0,
                  );
                  final expires = DateHelper.daysUntilExpiration(expireDate);
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: Constants.generalPadding,
                    ),
                    child: _ExpiringItemCard(
                      name: expiringSoonItem?.name ?? '',
                      imageUrl: expiringSoonItem?.imageUrl ?? '',
                      quantity:
                          expiringSoonItem?.quantity?.value.toString() ?? '',
                      expires: expires.toString(),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
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
          Padding(
            padding: const EdgeInsets.all(Constants.generalPadding),
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
