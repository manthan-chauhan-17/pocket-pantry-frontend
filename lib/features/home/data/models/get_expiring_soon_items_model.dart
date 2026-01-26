// To parse this JSON data, do
//clear

//     final getExpiringSoonItemsModel = getExpiringSoonItemsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:pocket_pantry_frontend/features/home/domain/entities/get_expiring_soon_items_entity.dart';

part 'get_expiring_soon_items_model.g.dart';

GetExpiringSoonItemsModel getExpiringSoonItemsModelFromJson(String str) =>
    GetExpiringSoonItemsModel.fromJson(json.decode(str));

String getExpiringSoonItemsModelToJson(GetExpiringSoonItemsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetExpiringSoonItemsModel {
  @JsonKey(name: "statusCode")
  int? statusCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "expiringSoonItems")
  List<ExpiringSoonItem>? expiringSoonItems;

  GetExpiringSoonItemsModel({
    this.statusCode,
    this.message,
    this.success,
    this.expiringSoonItems,
  });

  factory GetExpiringSoonItemsModel.fromJson(Map<String, dynamic> json) =>
      _$GetExpiringSoonItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetExpiringSoonItemsModelToJson(this);

  GetExpiringSoonItemsEntity toEntity() => GetExpiringSoonItemsEntity(
    statusCode: statusCode,
    message: message,
    success: success,
    expiringSoonItems: expiringSoonItems?.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable()
class ExpiringSoonItem {
  @JsonKey(name: "image")
  Image? image;
  @JsonKey(name: "quantity")
  Quantity? quantity;
  @JsonKey(name: "lowStockThreshold")
  LowStockThreshold? lowStockThreshold;
  @JsonKey(name: "_id")
  String? id;
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

  ExpiringSoonItem({
    this.image,
    this.quantity,
    this.lowStockThreshold,
    this.id,
    this.itemName,
    this.itemDescription,
    this.expireDate,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory ExpiringSoonItem.fromJson(Map<String, dynamic> json) =>
      _$ExpiringSoonItemFromJson(json);

  Map<String, dynamic> toJson() => _$ExpiringSoonItemToJson(this);

  ExpiringSoonItemEntity toEntity() => ExpiringSoonItemEntity(
    image: image?.toEntity(),
    quantity: quantity?.toEntity(),
    lowStockThreshold: lowStockThreshold?.toEntity(),
    id: id,
    itemName: itemName,
    itemDescription: itemDescription,
    expireDate: expireDate,
    category: category,
    createdAt: createdAt,
    updatedAt: updatedAt,
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

  ItemImageEntity toEntity() => ItemImageEntity(url: url, publicId: publicId);
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

  QuantityEntity toEntity() => QuantityEntity(value: value, unit: unit);
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
