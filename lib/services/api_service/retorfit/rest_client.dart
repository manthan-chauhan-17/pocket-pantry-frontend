import 'package:dio/dio.dart';
import 'package:pocket_pantry_frontend/feature/add-item/model/add_item_model.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';
import 'package:pocket_pantry_frontend/feature/auth/models/user_model.dart';
import 'package:pocket_pantry_frontend/feature/item-detail/model/item_detail_model.dart';
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
  Future<AddItemModel> addItem(
    @Header('Authorization') String token,
    @Body() FormData body,
  );

  @DELETE('item/delete-item')
  Future deleteItem(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  @POST('item/get-single-item')
  Future<ItemDetailModel> getItem(
    @Body() Map<String, dynamic> body,
  );

  @POST('notification/register-token')
  Future<dynamic> registerFcmToken(@Body() Map<String, dynamic> body);
}
