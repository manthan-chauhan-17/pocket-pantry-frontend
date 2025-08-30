// add_item_event.dart
import 'dart:io';

abstract class AddItemEvent {}

class AddItemSubmitted extends AddItemEvent {
  final String itemName;
  final String itemDescription;
  final String category;
  final int expireDate;
  final File? image;

  AddItemSubmitted({
    required this.itemName,
    required this.itemDescription,
    required this.category,
    required this.expireDate,
    this.image,
  });
}

class ImageSelected extends AddItemEvent {
  final File image;

  ImageSelected(this.image);
}

class CategoryChanged extends AddItemEvent {
  final String category;

  CategoryChanged(this.category);
}
