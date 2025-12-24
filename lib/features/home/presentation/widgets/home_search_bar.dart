import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text_form_field.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;

  const HomeSearchBar({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constant.generalPadding),
      child: CustomTextFormField(
        controller: controller,
        hintText: hintText ?? 'Search pantry...',
        isPrefixIconOn: true,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.getColor(context).onSurfaceVariant,
        ),
        prefixIconColor: AppTheme.getColor(context).onSurfaceVariant,
        fillColor: AppTheme.getSurfaceContainer(context),
        textColor: AppTheme.getOnSurfaceContainer(context),
        hintColor: AppTheme.getColor(context).onSurfaceVariant,
        isSuffixIconOn: true,
        suffixIcon: Icon(
          Icons.tune,
          color: AppTheme.getColor(context).onSurfaceVariant,
        ),
        suffixIconColor: AppTheme.getColor(context).onSurfaceVariant,
      ),
    );
  }
}
