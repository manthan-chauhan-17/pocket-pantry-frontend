import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_state.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

class DropDownBloc extends Bloc<DropDownEvent, DropDownState> {
  DropDownBloc() : super(DropDownInitialState()) {
    on<GetDropDownItemsEvent>(selectedItem);
  }
  selectedItem(GetDropDownItemsEvent event, Emitter<DropDownState> emit) {
    emit(DropDownInitialState(selectedItem: event.item));
  }
}

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickState> {
  XFile? pickedImage;
  final ImagePicker _picker = ImagePicker();
  ImagePickerBloc() : super(ImageInitialState()) {
    on<PickImageEvent>(selectImage);
  }
  selectImage(PickImageEvent event, Emitter<ImagePickState> emit) async {
    if (event.source != null) {
      final XFile? image = await _picker.pickImage(source: event.source);
      if (image != null) {
        pickedImage = image;

        emit(ImagePickedState(imagePath: image.path));
      }
    }
  }
}

Future<void> _onUploadImage(UploadImageEvent event,
    Emitter<ImagePickState> emit, XFile? pickedImage) async {
  if (pickedImage == null) {
    emit(UploadErrorState('No image selected'));
    return;
  }

  try {
    emit(UploadLoadingState());

    final file = await File.fromRawPath(
      await pickedImage!.readAsBytes(),
    );

    await Api.uploadItemWithImage(
      event.token,
      event.expiredate,
      event.name,
      event.description,
      event.category,
      file,
    );

    emit(UploadSuccessState());
  } catch (e) {
    emit(UploadErrorState(e.toString()));
  }
}
