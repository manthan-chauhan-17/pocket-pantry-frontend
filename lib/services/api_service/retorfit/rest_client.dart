import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';
import 'package:pocket_pantry_frontend/feature/auth/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('healthcheck')
  Future<dynamic> healthcheck();

  @POST('auth/register')
  Future<UserModel> register(@Body() Map<String, dynamic> body);

  @POST('auth/login')
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @GET('item/get-items')
  Future<ItemModel> getItems(
    @Header('Authorization') String token,
  );

  @POST('item/add-item')
  @MultiPart()
  Future<HttpResponse> addItem(
    @Header('Authorization') String token,
    @Part(name: 'itemName') String itemName,
    @Part(name: 'itemDescription') String itemDescription,
    @Part(name: 'expireDate') String expireDate,
    @Part(name: 'category') String category,
    @Part(name: 'image') File image,
  );
}
