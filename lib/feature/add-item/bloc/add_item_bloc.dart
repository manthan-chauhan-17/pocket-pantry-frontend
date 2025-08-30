// add_item_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:pocket_pantry_frontend/feature/add-item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add-item/bloc/add_item_state.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  File? selectedImage;
  String selectedCategory = '';

  AddItemBloc() : super(AddItemInitial()) {
    on<AddItemSubmitted>(_onAddItemSubmitted);
    on<ImageSelected>(_onImageSelected);
    on<CategoryChanged>(_onCategoryChanged);
  }

  void _onImageSelected(ImageSelected event, Emitter<AddItemState> emit) {
    selectedImage = event.image;
    emit(ImageSelectedState(event.image));
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<AddItemState> emit) {
    selectedCategory = event.category;
    emit(CategorySelectedState(event.category));
  }

  void _onAddItemSubmitted(
      AddItemSubmitted event, Emitter<AddItemState> emit) async {
    emit(AddItemLoading());

    try {
      // String token = await MySharedPreference.getToken();

      FormData formData = FormData.fromMap({
        'itemName': event.itemName,
        'itemDescription': event.itemDescription,
        'expireDate': event.expireDate,
        'category': event.category,
        if (event.image != null)
          'image': await MultipartFile.fromFile(
            event.image?.path ?? '',
          ),
      });

      log(formData.fields.toString(), name: "FORM_DATA");

      final response = await Api.uploadItemWithImage(body: formData);

      emit(AddItemSuccess(response.message.toString()));
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      emit(AddItemError('Failed to add item: ${e.toString()}'));
    }
  }
}
