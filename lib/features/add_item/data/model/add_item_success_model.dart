// To parse this JSON data, do
//
//     final addItemSuccessModel = addItemSuccessModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:pocket_pantry_frontend/features/add_item/domain/entities/add_item_success_entity.dart';

part 'add_item_success_model.g.dart';

AddItemSuccessModel addItemSuccessModelFromJson(String str) =>
    AddItemSuccessModel.fromJson(json.decode(str));

String addItemSuccessModelToJson(AddItemSuccessModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AddItemSuccessModel {
  @JsonKey(name: "statusCode")
  int? statusCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "itemId")
  String? itemId;

  AddItemSuccessModel({
    this.statusCode,
    this.message,
    this.success,
    this.itemId,
  });

  factory AddItemSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$AddItemSuccessModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddItemSuccessModelToJson(this);

  AddItemSuccessEntity toEntity() {
    return AddItemSuccessEntity(
      statusCode: statusCode,
      message: message,
      success: success,
      itemId: itemId,
    );
  }
}
