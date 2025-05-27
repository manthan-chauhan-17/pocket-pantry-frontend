import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_state.dart';

import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> items = [
    "Vegetables",
    "Fruits",
    "Dairy",
    "Grains",
    "Spices",
    "Beverages",
    "Snacks",
    "Frozen",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Item',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<DropDownBloc, DropDownState>(
        listener: (context, state) => {},
        builder: (context, state) {
          String? selectedItem =
              state is DropDownInitialState ? state.selectedItem : null;
          return Column(
            children: [
              CustomTextField(
                controller: itemNameController,
                fieldType: FieldType.name,
                labelText: 'Item Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 0.01 * getHeight(context),
              ),
              SizedBox(
                width: 0.94 * getWidth(context),
                child: DropdownButtonFormField(
                  value: selectedItem,
                  items: items
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<DropDownBloc>()
                          .add(GetDropDownItemsEvent(item: value));
                    }
                  },
                  decoration: InputDecoration(
                    hintText: selectedItem ?? 'Select Category',
                    filled: true,
                    fillColor: AppColors.greenTextField,
                    contentPadding: EdgeInsets.all(16 * getResponsive(context)),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12 * getResponsive(context)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: AppColors.greenTextField,
                ),
              ),
              SizedBox(
                height: 0.01 * getHeight(context),
              ),
              CustomTextField(
                hintText: "Description",
                line: 5,
                controller: descriptionController,
                fieldType: FieldType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
