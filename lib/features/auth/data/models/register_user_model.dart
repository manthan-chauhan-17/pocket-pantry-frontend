// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:pocket_pantry_frontend/features/auth/domain/entities/register_user_entity.dart';

part 'register_user_model.g.dart';

RegisterUserModel registerUserModelFromJson(String str) =>
    RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RegisterUserModel {
  @JsonKey(name: "statusCode")
  int? statusCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "user")
  User? user;

  RegisterUserModel({this.statusCode, this.message, this.success, this.user});

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserModelToJson(this);

  RegisterUserEntity toEntity() => RegisterUserEntity(
    statusCode: statusCode,
    message: message,
    success: success,
    user: user?.toUserEntity(),
  );
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  UserEntity toUserEntity() => UserEntity(id: id, name: name, email: email);
}
