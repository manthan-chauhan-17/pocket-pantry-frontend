import 'package:equatable/equatable.dart';

abstract class DropDownState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class ImagePickState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DropDownInitialState extends DropDownState {
  final String? selectedItem;

  DropDownInitialState({this.selectedItem});

  @override
  List<Object?> get props => [selectedItem];
}

class ImageInitialState extends ImagePickState {}

class ImagePickedState extends ImagePickState {
  final String imagePath;

  ImagePickedState({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class UploadLoadingState extends ImagePickState {}

class UploadSuccessState extends ImagePickState {}

class UploadErrorState extends ImagePickState {
  final String message;
  UploadErrorState(this.message);
}
