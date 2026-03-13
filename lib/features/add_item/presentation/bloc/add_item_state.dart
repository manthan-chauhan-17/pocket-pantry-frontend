part of 'add_item_bloc.dart';

sealed class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object?> get props => [];
}

final class AddItemInitial extends AddItemState {}

class ImagePickedState extends AddItemState {
  final String imagePath;

  const ImagePickedState({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class ImageRemovedState extends AddItemState {}
