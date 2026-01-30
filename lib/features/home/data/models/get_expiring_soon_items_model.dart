// To parse this JSON data, do
//
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
  @JsonKey(name: "items")
  List<ExpiringSoonItem>? items;
  @JsonKey(name: "meta")
  ExpiringSoonMeta? meta;

  GetExpiringSoonItemsModel({
    this.statusCode,
    this.message,
    this.success,
    this.items,
    this.meta,
  });

  factory GetExpiringSoonItemsModel.fromJson(Map<String, dynamic> json) =>
      _$GetExpiringSoonItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetExpiringSoonItemsModelToJson(this);

  GetExpiringSoonItemsEntity toEntity() => GetExpiringSoonItemsEntity(
    statusCode: statusCode,
    message: message,
    success: success,
    items: items?.map((e) => e.toEntity()).toList(),
    meta: meta?.toEntity(),
  );
}

@JsonSerializable()
class ExpiringSoonItem {
  @JsonKey(name: "itemId")
  String? itemId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "expireDate")
  int? expireDate;
  @JsonKey(name: "quantity")
  ExpiringSoonQuantity? quantity;
  @JsonKey(name: "lowStockThreshold")
  ExpiringSoonLowStockThreshold? lowStockThreshold;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "imageUrl")
  String? imageUrl;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  ExpiringSoonItem({
    this.itemId,
    this.name,
    this.expireDate,
    this.quantity,
    this.lowStockThreshold,
    this.category,
    this.imageUrl,
    this.createdAt,
  });

  factory ExpiringSoonItem.fromJson(Map<String, dynamic> json) =>
      _$ExpiringSoonItemFromJson(json);

  Map<String, dynamic> toJson() => _$ExpiringSoonItemToJson(this);

  ExpiringSoonItemEntity toEntity() => ExpiringSoonItemEntity(
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
class ExpiringSoonLowStockThreshold {
  @JsonKey(name: "value")
  int? value;
  @JsonKey(name: "unit")
  String? unit;

  ExpiringSoonLowStockThreshold({this.value, this.unit});

  factory ExpiringSoonLowStockThreshold.fromJson(Map<String, dynamic> json) =>
      _$ExpiringSoonLowStockThresholdFromJson(json);

  Map<String, dynamic> toJson() => _$ExpiringSoonLowStockThresholdToJson(this);

  ExpiringSoonLowStockThresholdEntity toEntity() =>
      ExpiringSoonLowStockThresholdEntity(value: value, unit: unit);
}

@JsonSerializable()
class ExpiringSoonQuantity {
  @JsonKey(name: "value")
  int? value;
  @JsonKey(name: "unit")
  String? unit;

  ExpiringSoonQuantity({this.value, this.unit});

  factory ExpiringSoonQuantity.fromJson(Map<String, dynamic> json) =>
      _$ExpiringSoonQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$ExpiringSoonQuantityToJson(this);

  ExpiringSoonQuantityEntity toEntity() =>
      ExpiringSoonQuantityEntity(value: value, unit: unit);
}

@JsonSerializable()
class ExpiringSoonMeta {
  @JsonKey(name: "total")
  int? total;

  ExpiringSoonMeta({this.total});

  factory ExpiringSoonMeta.fromJson(Map<String, dynamic> json) =>
      _$ExpiringSoonMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ExpiringSoonMetaToJson(this);

  ExpiringSoonMetaEntity toEntity() => ExpiringSoonMetaEntity(total: total);
}
