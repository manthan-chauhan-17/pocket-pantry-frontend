// add_item_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:pocket_pantry_frontend/feature/add-item/bloc/add_item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/add-item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add-item/bloc/add_item_state.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/utils/date_helper.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  final _expiryDateController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String selectedCategory = '';
  int? expireDateTimestamp;
  final List<String> categories = [
    'Dairy',
    'Meat',
    'Vegetables',
    'Fruits',
    'Grains',
    'Beverages',
    'Snacks',
    'Frozen',
    'Condiments',
    'Other'
  ];

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemDescriptionController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
        context.read<AddItemBloc>().add(ImageSelected(File(image.path)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Color(0xFF7CB342)),
              title: Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Color(0xFF7CB342)),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF7CB342),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _expiryDateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

        expireDateTimestamp = DateHelper.dateTimeToTimestamp(picked);
      });
    }
  }

  void _showCategoryDropdown() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            ...categories
                .map((category) => ListTile(
                      title: Text(category),
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                        // context
                        //     .read<AddItemBloc>()
                        //     .add(CategoryChanged(category));
                        Navigator.pop(context);
                      },
                      trailing: selectedCategory == category
                          ? Icon(Icons.check, color: Color(0xFF7CB342))
                          : null,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedCategory.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a category')),
        );
        return;
      }

      if (_expiryDateController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an expiry date')),
        );
        return;
      }

      context.read<AddItemBloc>().add(AddItemSubmitted(
            itemName: _itemNameController.text.trim(),
            itemDescription: _itemDescriptionController.text.trim(),
            category: selectedCategory,
            expireDate: expireDateTimestamp ?? -1,
            image: selectedImage,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close,
              color: AppTheme.getColor(context).onSurface,
              size: 24 * getResponsive(context)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Item',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20 * getResponsiveText(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AddItemBloc, AddItemState>(
        listener: (context, state) {
          if (state is AddItemSuccess) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Success",
                message: state.message,
                contentType: ContentType.success);

            ScaffoldMessenger.of(context).showSnackBar(snackbar);

            Navigator.of(context).pop();
          } else if (state is AddItemError) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Error",
                message: state.error,
                contentType: ContentType.failure);

            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(22 * getResponsive(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    controller: _itemNameController,
                    hintText: 'Item Name',
                    fieldType: FieldType.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Item name is required';
                      }
                      return null;
                    }),

                SizedBox(height: 0.01 * getHeight(context)),

                // Category Field
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.03 * getWidth(context)),
                  child: GestureDetector(
                    onTap: _showCategoryDropdown,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.getColor(context).onSurfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18 * getResponsive(context),
                        vertical: 20 * getResponsive(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedCategory.isEmpty
                                ? 'Category'
                                : selectedCategory,
                            style: TextStyle(
                              color: selectedCategory.isEmpty
                                  ? AppTheme.getColor(context).onSurface
                                  : Colors.black,
                              fontSize: 18 * getResponsiveText(context),
                            ),
                          ),
                          Transform.rotate(
                            angle: 1.5708, // 90 degrees in radians
                            child: Icon(
                              Icons.chevron_right,
                              color: Color(0xFF8BC34A),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 0.01 * getHeight(context)),

                // Item Description Field
                CustomTextField(
                  controller: _itemDescriptionController,
                  hintText: 'Item Description',
                  fieldType: FieldType.description,
                  line: 4,
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 0.01 * getHeight(context)),

                // Upload Image Section
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.03 * getWidth(context)),
                  child: Text(
                    'Upload Image',
                    style: TextStyle(
                      fontSize: 18 * getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 0.01 * getHeight(context)),

                // Image Upload Container
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.03 * getWidth(context)),
                  child: GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Container(
                      width: double.infinity,
                      height: selectedImage != null
                          ? 0.3 * getHeight(context)
                          : 0.25 * getHeight(context),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFE0E0E0),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 34 * getResponsive(context),
                                  color: Colors.grey[600],
                                ),
                                SizedBox(height: 0.001 * getHeight(context)),
                                Text(
                                  'Add a photo',
                                  style: TextStyle(
                                    fontSize: 20 * getResponsiveText(context),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Take a photo of the item or upload one from\nyour library',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16 * getResponsiveText(context),
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 0.02 * getHeight(context)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 22 * getResponsive(context),
                                    vertical: 10 * getResponsive(context),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.getColor(context).onSurface,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                      fontSize: 16 * getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.getColor(context).surface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 0.01 * getHeight(context)),

                // Expiry Date Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.03 * getWidth(context),
                  ),
                  child: Text(
                    'Expiry Date',
                    style: TextStyle(
                      fontSize: 18 * getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 0.01 * getHeight(context)),

                // Expiry Date Field
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.03 * getWidth(context)),
                  child: GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.getColor(context).onSurfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18 * getResponsive(context),
                        vertical: 20 * getResponsive(context),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _expiryDateController.text.isEmpty
                                  ? 'Select Expiry Date'
                                  : _expiryDateController.text,
                              style: TextStyle(
                                color: _expiryDateController.text.isEmpty
                                    ? AppTheme.getColor(context).onSurface
                                    : Colors.black,
                                fontSize: 18 * getResponsiveText(context),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppTheme.getColor(context).onSurface,
                            size: 22 * getResponsive(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),

                // Add Item Button
                BlocBuilder<AddItemBloc, AddItemState>(
                  builder: (context, state) {
                    return Center(
                      child: SizedBox(
                        width: 0.83 * getWidth(context),
                        height: 0.06 * getHeight(context),
                        child: ElevatedButton(
                          onPressed:
                              state is AddItemLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.getColor(context).primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 0,
                          ),
                          child: state is AddItemLoading
                              ? SizedBox(
                                  height: 24 * getResponsive(context),
                                  width: 24 * getResponsive(context),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  'Add Item',
                                  style: TextStyle(
                                    fontSize: 18 * getResponsiveText(context),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
