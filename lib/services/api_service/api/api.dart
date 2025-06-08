import 'dart:developer';
import 'dart:io';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';
import 'package:pocket_pantry_frontend/feature/auth/models/user_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/retorfit/injection.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';

class Api {
  // Healthcheck
  static checkHealthApi() async {
    await restClient.healthcheck().then((value) {
      log('Healthcheck API response: $value', name: 'ApiService');
    }).catchError((error) {
      log('Error in healthcheck API: $error', name: 'ApiService');
    });
  }

  // Register User
  static Future<UserModel> registerUser(
      String name, String email, String password) async {
    Map<String, dynamic> body = {};
    body['name'] = name;
    body['email'] = email;
    body['password'] = password;

    log(body.toString(), name: "BODY");
    // var jsonBody = jsonEncode(body);
    try {
      UserModel result = await restClient.register(body);
      return result;
    } catch (e) {
      log(e.toString(), name: "Error in registering user");
      rethrow;
    }
  }

  // Login user
  static Future<UserModel> loginUser(String email, String password) async {
    Map<String, dynamic> body = {};
    body['email'] = email;
    body['password'] = password;

    try {
      UserModel result = await restClient.login(body);
      return result;
    } catch (e) {
      log(e.toString(), name: "Error in login user");
      rethrow;
    }
  }

  // Get Items
  static Future<ItemModel> getItems() async {
    try {
      String token = await MySharedPreference.getToken();
      log(token, name: "TOKEN");
      ItemModel response = await restClient.getItems('Bearer $token');
      log(response.toString(), name: "response get item api ");
      return response;
    } catch (e) {
      log(e.toString(), name: "Error in get items");
      rethrow;
    }
  }

  // Add Item with Image
  static uploadItemWithImage(
      {required String itemName,
      required String itemDescription,
      required String category,
      required String expireDate,
      required File image}) async {
    String token = await MySharedPreference.getToken();

    final response = restClient.addItem("Bearer $token", itemName,
        itemDescription, expireDate, category, image);

    log(response.toString(), name: "RESINAPI");

    return response;
  }

  static deleteItemFromList({required String id}) async {
    String token = await MySharedPreference.getToken();
    Map<String, dynamic> body = {};
    body['itemId'] = id;

    final response = await restClient.deleteItem("Bearer $token", body);

    log(response.toString(), name: "Delete Res");

    return response;
  }
}
