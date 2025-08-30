// add_item_state.dart
import 'dart:io';

abstract class AddItemState {}

class AddItemInitial extends AddItemState {}

class AddItemLoading extends AddItemState {}

class AddItemSuccess extends AddItemState {
  final String message;

  AddItemSuccess(this.message);
}

class AddItemError extends AddItemState {
  final String error;

  AddItemError(this.error);
}

class ImageSelectedState extends AddItemState {
  final File image;

  ImageSelectedState(this.image);
}

class CategorySelectedState extends AddItemState {
  final String category;

  CategorySelectedState(this.category);
}
