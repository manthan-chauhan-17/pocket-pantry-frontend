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
  @JsonKey(name: "meta")
  Meta? meta;

  GetItemsModel({
    this.statusCode,
    this.message,
    this.success,
    this.items,
    this.meta,
  });

  factory GetItemsModel.fromJson(Map<String, dynamic> json) =>
      _$GetItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetItemsModelToJson(this);

  GetItemsEntity toEntity() => GetItemsEntity(
    statusCode: statusCode,
    message: message,
    success: success,
    items: items?.map((e) => e.toEntity()).toList(),
    meta: meta?.toEntity(),
  );
}

@JsonSerializable()
class Item {
  @JsonKey(name: "itemId")
  String? itemId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "expireDate")
  int? expireDate;
  @JsonKey(name: "quantity")
  Quantity? quantity;
  @JsonKey(name: "lowStockThreshold")
  LowStockThreshold? lowStockThreshold;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "imageUrl")
  String? imageUrl;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  Item({
    this.itemId,
    this.name,
    this.expireDate,
    this.quantity,
    this.lowStockThreshold,
    this.category,
    this.imageUrl,
    this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  ItemEntity toEntity() => ItemEntity(
    itemId: itemId,
    name: name,
    expireDate: expireDate,
    quantity: quantity?.toEntity(),
    lowStockThreshold: lowStockThreshold?.toEntity(),
    category: category,
    imageUrl: imageUrl,
    createdAt: createdAt,
  );
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

  QuantityEntity toEntity() => QuantityEntity(value: value, unit: unit);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "total")
  int? total;

  Meta({this.total});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  MetaEntity toEntity() => MetaEntity(total: total);
}
