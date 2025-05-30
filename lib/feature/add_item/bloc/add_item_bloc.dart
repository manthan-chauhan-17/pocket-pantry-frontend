import 'dart:developer';
import 'dart:io';

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
  final ImagePicker _picker = ImagePicker();
   XFile? selectedImage;
  ImagePickerBloc() : super(ImageInitialState()) {
    on<PickImageEvent>(selectImage);
    on<UploadImageEvent>(uploadImage);
  }
  selectImage(PickImageEvent event, Emitter<ImagePickState> emit) async {
    if (event.source != null) {
      final XFile? image = await _picker.pickImage(source: event.source!);
      if (image != null) {
        selectedImage = image;  
        emit(ImagePickedState(imagePath: image.path));
      }
    }
  }

  uploadImage(UploadImageEvent event, Emitter<ImagePickState> emit) async {
    if(selectedImage == null){
      emit(UploadErrorState("Upload Image"));
      return;
    }

    emit(UploadLoadingState());
    try {
      log("message",name: 'IMAGE EVENT');
      await Api.uploadItemWithImage(event.expireDate, event.name,
          event.description, event.category,File(selectedImage!.path));
      emit(UploadSuccessState());
    } catch (e) {
      emit(UploadErrorState(e.toString()));
    }
  }
}
