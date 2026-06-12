import 'dart:io';
import 'package:dio/dio.dart';

class AddItemRequestModel {
  final String itemName;
  final String itemDescription;
  final int expireDate;
  final String category;
  final int quantityValue;
  final String quantityUnit;
  final int lowStockThresholdValue;
  final File? image;

  AddItemRequestModel({
    required this.itemName,
    required this.itemDescription,
    required this.expireDate,
    required this.category,
    required this.quantityValue,
    required this.quantityUnit,
    required this.lowStockThresholdValue,
    this.image,
  });

  /// Optional: If you ever need normal JSON
  Map<String, dynamic> toJson() {
    return {
      "itemName": itemName,
      "itemDescription": itemDescription,
      "expireDate": expireDate,
      "category": category,
      "quantityValue": quantityValue,
      "quantityUnit": quantityUnit,
      "lowStockThresholdValue": lowStockThresholdValue,
    };
  }

  /// Multipart FormData for API
  FormData toFormData() {
    return FormData.fromMap({
      "itemName": itemName,
      "itemDescription": itemDescription,
      "expireDate": expireDate,
      "category": category,
      "quantityValue": quantityValue,
      "quantityUnit": quantityUnit,
      "lowStockThresholdValue": lowStockThresholdValue,
      if (image != null)
        "image": MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
    });
  }
}
