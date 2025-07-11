import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_state.dart';
import 'package:pocket_pantry_frontend/feature/add_item/model/add_item_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_helper/hive_helper.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_model/hive_item_model.dart';

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
    // on<UploadImageEvent>(uploadImage);
    on<UploadImageEvent>(uploadImage1);
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

  uploadImage1(UploadImageEvent event, Emitter<ImagePickState> emit) async {
    if (selectedImage == null) {
      emit(UploadErrorState("Uploading image is required"));
    }

    emit(UploadLoadingState());

    try {
      AddItemModel res = await Api.uploadItemWithImage(
          itemName: event.name,
          itemDescription: event.description,
          category: event.category,
          expireDate: event.expireDate,
          image: File(selectedImage!.path));

      Item addedItem = res.item!;

      final hiveItem = HiveItemModel(
          id: addedItem.id!,
          itemName: addedItem.itemName!,
          itemDescription: addedItem.itemDescription!,
          expireDate: addedItem.expireDate!,
          category: addedItem.category!,
          imageUrl: addedItem.image!.url!,
          imagePublicId: addedItem.image!.publicId!);

      await HiveItemHelper.addItem(hiveItem);

      log(res.toString(), name: "RESINBLOC");
      emit(UploadSuccessState());
    } catch (e) {
      log(e.toString(), name: "BLOCERROR");
      emit(UploadErrorState(e.toString()));
    }
  }
}
