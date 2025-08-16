import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_state.dart';
import 'package:pocket_pantry_frontend/responsive.dart';

// ignore: must_be_immutable
class ImagePickedBox extends StatelessWidget {
  File? imageFile;
  ImagePickedBox({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ImagePickedState) {
          imageFile = File(state.imagePath);
        }
        return Stack(
          children: [
            DottedBorder(
              options: RectDottedBorderOptions(
                // borderPadding: EdgeInsets.all(8 * getResponsive(context)),

                color: AppColors.greenTextField,
                strokeWidth: 2 * getResponsive(context),
                dashPattern: [8, 4],
              ),
              child: Container(
                height: 0.3 * getHeight(context),
                width: 0.92 * getWidth(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10 * getResponsive(context),
                    )),
                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12 * getResponsive(context),
                        ),
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add a Photo',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24 * getResponsive(context),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 0.01 * getHeight(context)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.05 * getWidth(context),
                              ),
                              child: Text(
                                'Take a Photo of the item or upload one from your library',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16 * getResponsive(context),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 0.02 * getHeight(context)),
                            ElevatedButton(
                                onPressed: () {
                                  _showImageSourceBottomSheet(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    AppColors.greenTextField,
                                  ),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      40 * getResponsive(context),
                                    ),
                                  )),
                                ),
                                child: Text('Upload')),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                context
                    .read<ImagePickerBloc>()
                    .add(PickImageEvent(source: ImageSource.camera));
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                context
                    .read<ImagePickerBloc>()
                    .add(PickImageEvent(source: ImageSource.gallery));
              },
            ),
          ],
        );
      },
    );
  }
}
