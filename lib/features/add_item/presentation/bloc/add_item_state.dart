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

class AddItemsLoadingState extends AddItemState {}

class AddItemsSuccessState extends AddItemState {
  final AddItemSuccessEntity addItemSuccessEntity;

  const AddItemsSuccessState({required this.addItemSuccessEntity});

  @override
  List<Object?> get props => [addItemSuccessEntity];
}

class AddItemsErrorState extends AddItemState {
  final String message;

  const AddItemsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
