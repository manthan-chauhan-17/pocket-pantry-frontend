import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/bloc/home_bloc.dart';

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
        if (state.allItemsLoading) {
          return SizedBox(
            height: 0.28 * Responsive.getHeight(context),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.allItemsErrorMessage.isNotEmpty) {
          return SizedBox(
            height: 0.28 * Responsive.getHeight(context),
            child: Center(child: CustomText('Error loading items')),
          );
        }

        if (state.getItemsEntity != null) {
          final items = state.getItemsEntity?.items;

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
                  name: item?.itemName ?? '',
                  imageUrl: item?.image?.url ?? '',
                  quantity: item?.quantity?.value.toString() ?? '',
                  expires: expires.toString(),
                  expiresColor: const Color(0xFFFF9500), // Orange
                  // tag: item?.itemTag,
                );
              },
            ),
          );
        }

        return SizedBox.shrink();
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
