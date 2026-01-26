import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _quantityController = TextEditingController(
    text: '1',
  );
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _lowStockAlertController = TextEditingController(
    text: '2',
  );

  String? _selectedCategory;
  String? _selectedImagePath;
  DateTime? _selectedExpiryDate;
  String _selectedUnit = 'pcs';
  bool _isLowStockAlertEnabled = true;

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

  final List<String> _units = ['pcs', 'kg', 'g', 'L', 'ml'];

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    _lowStockAlertController.dispose();
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

  void _setExpiryDateFromDuration(Duration duration) {
    final newDate = DateTime.now().add(duration);
    setState(() {
      _selectedExpiryDate = newDate;
      _expiryDateController.text = DateHelper.formatShortDate(newDate);
    });
  }

  Future<void> _pickImage() async {
    // TODO: Implement image picker
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
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
      backgroundColor: AppTheme.getColor(context).surface,
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

  void _showUnitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.getColor(context).surface,
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
                'Select Unit',
                fontSize: 20 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w600,
                color: AppTheme.getColor(context).onSurface,
              ),
              const SizedBox(height: 20),
              // Unit list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _units.length,
                  itemBuilder: (context, index) {
                    final unit = _units[index];
                    final isSelected = _selectedUnit == unit;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: CustomText(
                        unit,
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
                          _selectedUnit = unit;
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

  void _incrementQuantity() {
    final currentValue = int.tryParse(_quantityController.text) ?? 1;
    setState(() {
      _quantityController.text = (currentValue + 1).toString();
    });
  }

  void _decrementQuantity() {
    final currentValue = int.tryParse(_quantityController.text) ?? 1;
    if (currentValue > 1) {
      setState(() {
        _quantityController.text = (currentValue - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getColor(context).surface,
      appBar: AppBar(
        title: CustomText(
          'Add Item',
          fontSize: 18 * Responsive.getResponsiveText(context),
          fontWeight: FontWeight.w600,
          color: AppTheme.getColor(context).onSurface,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.getColor(context).surface,
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
                // spacing: 0.02 * Responsive.getHeight(context),
                children: [
                  // Item Name & Category Card
                  Card(child: _buildBasicInfoCard(context)),

                  // Expiration Date Card
                  Card(child: _buildExpirationDateCard(context)),

                  // Quantity Card
                  Card(child: _buildQuantityCard(context)),

                  // Additional Details Card
                  Card(child: _buildAdditionalDetailsCard(context)),

                  SizedBox(height: 0.02 * Responsive.getHeight(context)),

                  CustomButton(
                    text: 'Save',
                    buttonType: ButtonType.primary,
                    onPressed: _handleAddItem,
                    isEnabled: true,
                    isLoading: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard(BuildContext context) {
    return Card(
      color: AppTheme.getColor(context).surfaceBright,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Container(
        width: Responsive.getWidth(context),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Name
            Row(
              children: [
                CustomText(
                  'Item Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getColor(context).onSurface,
                ),
                const SizedBox(width: 4),
                CustomText(
                  '*',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _itemNameController,
              hintText: 'e.g., Almond Milk',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Item name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Category
            Row(
              children: [
                CustomText(
                  'Category',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getColor(context).onSurface,
                ),
                const SizedBox(width: 4),
                CustomText(
                  '*',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ],
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
                    color: AppTheme.getColor(context).onSurfaceVariant,
                    size: 20,
                  ),
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
    );
  }

  Widget _buildExpirationDateCard(BuildContext context) {
    return Card(
      color: AppTheme.getColor(context).surfaceBright,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Container(
        width: Responsive.getWidth(context),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with "Expiration Date" and "Best Before"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                      'Expiration Date',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.getColor(context).onSurface,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      '*',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ],
                ),
                CustomText(
                  'Best Before',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.getColor(context).onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date Picker
            GestureDetector(
              onTap: () => _selectExpiryDate(context),
              child: AbsorbPointer(
                child: CustomTextFormField(
                  controller: _expiryDateController,
                  hintText: 'mm/dd/yyyy',
                  isPrefixIconOn: true,
                  prefixIcon: Icon(
                    CupertinoIcons.calendar,
                    color: AppTheme.getColor(context).onSurfaceVariant,
                    size: 20,
                  ),
                  isSuffixIconOn: true,
                  suffixIcon: Icon(
                    CupertinoIcons.calendar,
                    color: AppTheme.getColor(context).onSurfaceVariant,
                    size: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Expiry date is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // // Quick Date Selection Buttons
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildQuickDateButton(
            //         context,
            //         '+3 Days',
            //         const Duration(days: 3),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: _buildQuickDateButton(
            //         context,
            //         '+1 Week',
            //         const Duration(days: 7),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: _buildQuickDateButton(
            //         context,
            //         '+2 Weeks',
            //         const Duration(days: 14),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: _buildQuickDateButton(
            //         context,
            //         '+1 Mo',
            //         const Duration(days: 30),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickDateButton(
    BuildContext context,
    String label,
    Duration duration,
  ) {
    return InkWell(
      onTap: () => _setExpiryDateFromDuration(duration),
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: label == '+3 Days'
              ? const Color(0xFFD4F6D4)
              : AppTheme.getSurfaceContainer(context),
          borderRadius: BorderRadius.circular(Constants.borderRadius),
          border: Border.all(
            color: label == '+3 Days'
                ? const Color(0xFF8BC34A)
                : AppTheme.getColor(context).outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: CustomText(
            label,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: label == '+3 Days'
                ? const Color(0xFF558B2F)
                : AppTheme.getColor(context).onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityCard(BuildContext context) {
    return Card(
      color: AppTheme.getColor(context).surfaceBright,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Container(
        width: Responsive.getWidth(context),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quantity
            Row(
              children: [
                CustomText(
                  'Quantity',
                  fontSize: 16 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getColor(context).onSurface,
                ),
                const SizedBox(width: 4),
                CustomText(
                  '*',
                  fontSize: 16 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Quantity Controls
            Row(
              children: [
                // Decrement button
                InkWell(
                  onTap: _decrementQuantity,
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.getSurfaceContainer(context),
                      borderRadius: BorderRadius.circular(
                        Constants.borderRadius,
                      ),
                      border: Border.all(
                        color: AppTheme.getColor(context).outline,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.minus,
                      color: AppTheme.getColor(context).onSurface,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Quantity Input
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.getSurfaceContainer(context),
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                    border: Border.all(
                      color: AppTheme.getColor(context).outline,
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    controller: _quantityController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getColor(context).onSurface,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Quantity is required';
                      } else if (int.parse(value) <= 0) {
                        return 'Quantity must be greater than 0';
                      } else if (int.parse(value) <=
                          int.parse(_lowStockAlertController.text)) {
                        return 'Quantity must be greater than low stock alert';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Increment button
                InkWell(
                  onTap: _incrementQuantity,
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8BC34A),
                      borderRadius: BorderRadius.circular(
                        Constants.borderRadius,
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Unit selector
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showUnitBottomSheet(context),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.getSurfaceContainer(context),
                        borderRadius: BorderRadius.circular(
                          Constants.borderRadius,
                        ),
                        border: Border.all(
                          color: AppTheme.getColor(context).outline,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            _selectedUnit,
                            fontSize: 14,
                            color: AppTheme.getColor(context).onSurface,
                          ),
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: AppTheme.getColor(context).onSurfaceVariant,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Low Stock Alert
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).surfaceContainerHighest,
                borderRadius: BorderRadius.circular(Constants.borderRadius),
              ),
              child: Column(
                children: [
                  // Alert toggle
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.getColor(context).onSurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.exclamationmark_triangle_fill,
                          color: Color(0xFFFF9800),
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Low Stock Alert',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.getColor(context).onSurface,
                            ),
                            CustomText(
                              'Get notified when running low',
                              fontSize: 12,
                              color: AppTheme.getColor(
                                context,
                              ).onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _isLowStockAlertEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isLowStockAlertEnabled = value;
                          });
                        },
                        activeThumbColor: const Color(0xFFFF9800),
                        activeTrackColor: const Color(0xFFFFCC80),
                      ),
                    ],
                  ),

                  // Alert threshold
                  if (_isLowStockAlertEnabled) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CustomText(
                          'Alert me when below:',
                          fontSize: 14,
                          color: AppTheme.getColor(context).onSurface,
                        ),
                        const Spacer(),
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Constants.borderRadius,
                            ),
                            border: Border.all(
                              color: AppTheme.getColor(context).outline,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _lowStockAlertController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.getColor(context).onSurface,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Low stock alert is required';
                                } else if (int.parse(value) <= 0) {
                                  return 'Low stock alert must be greater than 0';
                                } else if (int.parse(value) >=
                                    int.parse(_quantityController.text)) {
                                  return 'Low stock alert must be less than quantity';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          _selectedUnit,
                          fontSize: 14,
                          color: AppTheme.getColor(context).onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalDetailsCard(BuildContext context) {
    return Card(
      color: AppTheme.getColor(context).surfaceBright,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Container(
        width: Responsive.getWidth(context),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Additional Details',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.getColor(context).onSurface,
            ),
            const SizedBox(height: 16),

            // Item Photo
            Row(
              children: [
                CustomText(
                  'Item Photo',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getColor(context).onSurface,
                ),
                const SizedBox(width: 4),
                CustomText(
                  '*',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getColor(context).error,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Image Upload Area
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: AppTheme.getSurfaceContainer(context),
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                  border: Border.all(
                    color: AppTheme.getColor(context).outline.withOpacity(0.5),
                    width: 1.5,
                    style: BorderStyle.solid,
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
            const SizedBox(height: 16),

            // Notes
            CustomText(
              'Notes',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.getColor(context).onSurface,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.getSurfaceContainer(context),
                borderRadius: BorderRadius.circular(Constants.borderRadius),
                border: Border.all(
                  color: AppTheme.getColor(context).primary,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: _notesController,
                maxLines: 3,
                style: TextStyle(
                  color: AppTheme.getColor(context).onSurface,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText:
                      "Add brand details, preference note, or storage instructions...",
                  hintStyle: TextStyle(
                    color: AppTheme.getColor(context).onSurfaceVariant,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.getColor(context).surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              CupertinoIcons.camera_fill,
              size: 24,
              color: AppTheme.getColor(context).onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            'Upload Image',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.getColor(context).onSurface,
          ),
          const SizedBox(height: 4),
          CustomText(
            'Required',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppTheme.getColor(context).error,
          ),
        ],
      ),
    );
  }
}
