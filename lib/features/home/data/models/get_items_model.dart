// To parse this JSON data, do
//
//     final getItemsModel = getItemsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:pocket_pantry_frontend/features/home/domain/entities/get_items_entity.dart';

part 'get_items_model.g.dart';

GetItemsModel getItemsModelFromJson(String str) =>
    GetItemsModel.fromJson(json.decode(str));

String getItemsModelToJson(GetItemsModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetItemsModel {
  @JsonKey(name: "statusCode")
  int? statusCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "items")
  List<Item>? items;

  GetItemsModel({this.statusCode, this.message, this.success, this.items});

  factory GetItemsModel.fromJson(Map<String, dynamic> json) =>
      _$GetItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetItemsModelToJson(this);

  GetItemsEntity toEntity() => GetItemsEntity(
    items: items?.map((e) => e.toEntity()).toList(),
    statusCode: statusCode,
    message: message,
    success: success,
  );
}

@JsonSerializable()
class Item {
  @JsonKey(name: "image")
  Image? image;
  @JsonKey(name: "quantity")
  Quantity? quantity;
  @JsonKey(name: "lowStockThreshold")
  LowStockThreshold? lowStockThreshold;
  @JsonKey(name: "itemName")
  String? itemName;
  @JsonKey(name: "itemDescription")
  String? itemDescription;
  @JsonKey(name: "expireDate")
  int? expireDate;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "id")
  String? id;

  Item({
    this.image,
    this.quantity,
    this.lowStockThreshold,
    this.itemName,
    this.itemDescription,
    this.expireDate,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  ItemEntity toEntity() => ItemEntity(
    image: image?.toEntity(),
    quantity: quantity?.toEntity(),
    lowStockThreshold: lowStockThreshold?.toEntity(),
    itemName: itemName,
    itemDescription: itemDescription,
    expireDate: expireDate,
    category: category,
    createdAt: createdAt,
    updatedAt: updatedAt,
    id: id,
  );
}

@JsonSerializable()
class Image {
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "publicId")
  String? publicId;

  Image({this.url, this.publicId});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);

  ImageEntity toEntity() => ImageEntity(url: url, publicId: publicId);
}

@JsonSerializable()
class LowStockThreshold {
  @JsonKey(name: "value")
  int? value;
  @JsonKey(name: "unit")
  String? unit;

  LowStockThreshold({this.value, this.unit});

  factory LowStockThreshold.fromJson(Map<String, dynamic> json) =>
      _$LowStockThresholdFromJson(json);

  Map<String, dynamic> toJson() => _$LowStockThresholdToJson(this);

  LowStockThresholdEntity toEntity() =>
      LowStockThresholdEntity(value: value, unit: unit);
}
@JsonSerializable()
class Quantity {
  @JsonKey(name: "value")
  int? value;
  @JsonKey(name: "unit")
  String? unit;

  Quantity({this.value, this.unit});

  factory Quantity.fromJson(Map<String, dynamic> json) =>
      _$QuantityFromJson(json);

  Map<String, dynamic> toJson() => _$QuantityToJson(this);

  QuantityEntity toEntity() =>
      QuantityEntity(value: value, unit: unit);
}
