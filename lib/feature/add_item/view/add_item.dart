import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_state.dart';
import 'package:pocket_pantry_frontend/feature/add_item/view/image_picker.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
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

  var token;
  getToken() async {
    token = await MySharedPreference.getToken();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
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
          return SingleChildScrollView(
            child: Column(
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
                      contentPadding:
                          EdgeInsets.all(16 * getResponsive(context)),
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
                  line: 4,
                  controller: descriptionController,
                  fieldType: FieldType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 0.01 * getHeight(context),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.6 * getWidth(context)),
                  child: Text("Upload Image",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20 * getResponsive(context),
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 0.01 * getHeight(context),
                ),

                ///image container
                ImagePickedBox(),

                SizedBox(
                  height: 0.008 * getHeight(context),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.65 * getWidth(context)),
                  child: Text("Expired Date",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20 * getResponsive(context),
                          fontWeight: FontWeight.bold)),
                ),
                CustomTextField(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        expireDateController.text =
                            "${selectedDate.toLocal()}".split(' ')[0];
                      }
                    });
                  },
                  controller: expireDateController,
                  hintText: "Select Expiry Date",
                  fieldType: FieldType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
                ),
                Container(
                    width: 0.94 * getWidth(context),
                    height: 0.058 * getHeight(context),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.lightPrimaryGreen,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25 * getResponsive(context),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // context.read<ImagePickerBloc>().add(
                          //       UploadImageEvent(
                          //         name: itemNameController.text,
                          //         description: descriptionController.text,
                          //         category: selectedItem ?? '',
                          //         expiredate: expireDateController.text,
                          //         token: token,
                          //       ),
                          //     );

                          context.read<ImagePickerBloc>().add(UploadImageEvent(
                                category: selectedItem ?? '',
                                description: descriptionController.text,
                                expireDate: expireDateController.text,
                                name: itemNameController.text,
                              ));
                        },
                        child: Text(
                          "Add Item",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18 * getResponsiveText(context)),
                        ))),
                SizedBox(
                  height: 0.08 * getHeight(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
