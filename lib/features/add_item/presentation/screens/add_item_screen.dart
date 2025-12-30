import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_button.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text_form_field.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedCategory;
  String? _selectedImagePath;
  DateTime? _selectedExpiryDate;

  final List<String> _categories = [
    'Dairy',
    'Fruits',
    'Vegetables',
    'Meat',
    'Beverages',
    'Snacks',
    'Grains',
    'Spices',
    'Other',
  ];

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedExpiryDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.getColor(context).primary,
              onPrimary: AppTheme.getColor(context).onPrimary,
              surface: AppTheme.getSurfaceContainer(context),
              onSurface: AppTheme.getOnSurfaceContainer(context),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedExpiryDate) {
      setState(() {
        _selectedExpiryDate = picked;
        _expiryDateController.text = DateHelper.formatShortDate(picked);
      });
    }
  }

  Future<void> _pickImage() async {
    // TODO: Implement image picker
    // For now, this is just a placeholder
    // You can use image_picker package: final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Dairy':
        return CupertinoIcons.drop_fill;
      case 'Fruits':
        return Icons.apple;
      case 'Vegetables':
        return Icons.eco;
      case 'Meat':
        return Icons.set_meal;
      case 'Beverages':
        return CupertinoIcons.bubble_left_bubble_right_fill;
      case 'Snacks':
        return CupertinoIcons.bag_fill;
      case 'Grains':
        return Icons.grain;
      case 'Spices':
        return CupertinoIcons.star_fill;
      case 'Other':
        return CupertinoIcons.square_grid_2x2_fill;
      default:
        return CupertinoIcons.circle_fill;
    }
  }

  void _showCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.getColor(context).background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Constant.generalPadding,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.getColor(context).onSurfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              CustomText(
                'Select Category',
                fontSize: 20 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w600,
                color: AppTheme.getColor(context).onSurface,
              ),
              const SizedBox(height: 20),
              // Category list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.getColor(context).primaryContainer
                              : AppTheme.getSurfaceContainer(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getCategoryIcon(category),
                          color: isSelected
                              ? AppTheme.getColor(context).primary
                              : AppTheme.getColor(context).onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                      title: CustomText(
                        category,
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppTheme.getColor(context).primary
                            : AppTheme.getColor(context).onSurface,
                      ),
                      trailing: isSelected
                          ? Icon(
                              CupertinoIcons.checkmark_circle_fill,
                              color: AppTheme.getColor(context).primary,
                              size: 24,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                          _categoryController.text = category;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _handleAddItem() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement add item logic
      // Validate all fields and submit to backend
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.getColor(context).onSurface,
          ),
          onPressed: () => context.pop(),
        ),
        title: CustomText(
          'Add New Item',
          fontSize: 18 * Responsive.getResponsiveText(context),
          fontWeight: FontWeight.w600,
          color: AppTheme.getColor(context).onSurface,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.getColor(context).background,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(Constant.generalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Upload Section
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 0.25 * Responsive.getHeight(context),
                      decoration: BoxDecoration(
                        color: AppTheme.getSurfaceContainer(context),
                        borderRadius: BorderRadius.circular(
                          Constants.borderRadius,
                        ),
                        border: Border.all(
                          color: AppTheme.getColor(context).outline,
                          width: 1.5,
                        ),
                      ),
                      child: _selectedImagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Constants.borderRadius,
                              ),
                              child: Image.network(
                                _selectedImagePath!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildImagePlaceholder(context);
                                },
                              ),
                            )
                          : _buildImagePlaceholder(context),
                    ),
                  ),

                  SizedBox(height: 0.03 * Responsive.getHeight(context)),

                  // Item Name
                  CustomText(
                    'Item Name',
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getColor(context).onSurface,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _itemNameController,
                    hintText: 'e.g., Organic Eggs',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Item name is required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 0.02 * Responsive.getHeight(context)),

                  // Quantity & Category Row
                  Row(
                    children: [
                      // Quantity
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Quantity',
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w500,
                              color: AppTheme.getColor(context).onSurface,
                            ),
                            const SizedBox(height: 8),
                            CustomTextFormField(
                              controller: _quantityController,
                              hintText: 'e.g., 12',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Quantity is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Category',
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w500,
                              color: AppTheme.getColor(context).onSurface,
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => _showCategoryBottomSheet(context),
                              child: AbsorbPointer(
                                child: CustomTextFormField(
                                  controller: _categoryController,
                                  hintText: 'Select Category',
                                  isSuffixIconOn: true,
                                  suffixIcon: Icon(
                                    CupertinoIcons.chevron_down,
                                    color: AppTheme.getColor(context).primary,
                                  ),
                                  suffixIconColor: AppTheme.getColor(
                                    context,
                                  ).onSurfaceVariant,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Category is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 0.02 * Responsive.getHeight(context)),

                  // Expiry Date
                  CustomText(
                    'Expiry Date',
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getColor(context).onSurface,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectExpiryDate(context),
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        controller: _expiryDateController,
                        hintText: 'mm/dd/yyyy',
                        isSuffixIconOn: true,
                        suffixIcon: Icon(
                          CupertinoIcons.calendar,
                          color: AppTheme.getColor(context).primary,
                        ),
                        suffixIconColor: AppTheme.getColor(
                          context,
                        ).onSurfaceVariant,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Expiry date is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 0.02 * Responsive.getHeight(context)),

                  // Notes (Optional)
                  CustomText(
                    'Notes (Optional)',
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getColor(context).onSurface,
                  ),
                  const SizedBox(height: 8),
                  _buildNotesField(context),

                  SizedBox(height: 0.04 * Responsive.getHeight(context)),

                  // Add Item Button
                  CustomButton(
                    text: 'Add Item to Pantry',
                    buttonType: ButtonType.primary,
                    isFullWidth: true,
                    onPressed: _handleAddItem,
                    borderRadius: Constants.borderRadius * 2,
                    height: 50,
                  ),

                  SizedBox(height: 0.02 * Responsive.getHeight(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.camera,
            size: 40,
            color: AppTheme.getColor(context).onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          CustomText(
            'Add Photo',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.getColor(context).onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceContainer(context),
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        border: Border.all(color: AppTheme.getColor(context).primary, width: 1),
      ),
      child: TextFormField(
        controller: _notesController,
        maxLines: 4,
        style: TextStyle(color: AppTheme.getOnSurfaceContainer(context)),
        decoration: InputDecoration(
          hintText: "e.g., from farmer's market",
          hintStyle: TextStyle(
            color: AppTheme.getColor(context).onSurfaceVariant,
          ),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
