import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_request_model.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/entities/add_item_success_entity.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/usecases/add_item_usecase.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final ImagePicker _picker = ImagePicker();
  String?
  selectedImagePath; // Keep track of the image path locally in the bloc if needed
  final AddItemUsecase addItemUsecase;

  AddItemBloc({required this.addItemUsecase}) : super(AddItemInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<RemoveImageEvent>(_onRemoveImage);
    on<AddItemDetailsEvent>(_onAddItemDetails);
  }

  FutureOr<void> _onPickImage(
    PickImageEvent event,
    Emitter<AddItemState> emit,
  ) async {
    try {
      final XFile? image = await _picker.pickImage(source: event.source);
      if (image != null) {
        selectedImagePath = image.path;
        emit(ImagePickedState(imagePath: image.path));
      }
    } catch (e) {
      // You can emit an error state here if needed
      print("Error picking image: $e");
    }
  }

  FutureOr<void> _onRemoveImage(
    RemoveImageEvent event,
    Emitter<AddItemState> emit,
  ) {
    selectedImagePath = null;
    emit(ImageRemovedState());
  }

  FutureOr<void> _onAddItemDetails(
    AddItemDetailsEvent event,
    Emitter<AddItemState> emit,
  ) async {
    emit(AddItemsLoadingState());

    final result = await addItemUsecase.addItem(request: event.request);

    result.fold(
      (failure) {
        emit(AddItemsErrorState(message: failure.message));
      },
      (success) {
        emit(AddItemsSuccessState(addItemSuccessEntity: success));
      },
    );
  }
}
