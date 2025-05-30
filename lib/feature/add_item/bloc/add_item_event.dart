import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class DropDownEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDropDownItemsEvent extends DropDownEvent {
  final String? item;

  GetDropDownItemsEvent({this.item});

  @override
  List<Object?> get props => [item];
}

class PickImageEvent extends ImagePickerEvent {
  final ImageSource? source;

  PickImageEvent({this.source});

  @override
  List<Object?> get props => [source];
}

class UploadImageEvent extends ImagePickerEvent {
  final String name;
  final String description;
  final String category;
  final String expireDate;

  UploadImageEvent({
    required this.name,
    required this.description,
    required this.category,
    required this.expireDate,
  });

  @override
  List<Object?> get props => [name, description, category, expireDate];
}
