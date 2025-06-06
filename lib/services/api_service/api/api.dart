import 'dart:developer';
import 'dart:io';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';
import 'package:pocket_pantry_frontend/feature/auth/models/user_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api_helper.dart';
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

  // static uploadItemWithImage(String name, String description, String category,
  //     String expiredate, File imageFile) async {
  //   String token = await MySharedPreference.getToken();
  //   return await restClient
  //       .addItem(
  //           'Bearer $token', imageFile, name, description, category, expiredate)
  //       .then((value) {
  //     log('Item added successfully: $value', name: 'ApiService');
  //   }, onError: (error) {
  //     log('Error in adding item: $error', name: 'ApiService');
  //     throw error;
  //   });
  // }

  static uploadItemWithImage1(
      {required String itemName,
      required String itemDescription,
      required String category,
      required String expireDate,
      required File image}) async {
    String token = await MySharedPreference.getToken();
    Map<String, dynamic> body = {};
    body['itemName'] = itemName;
    body['itemDescription'] = itemDescription;
    body['category'] = category;
    body['expireDate'] = expireDate;

    final bodyParts = ApiHelper.convertMapToMultipartList(body);

    final response = restClient.addItem1("Bearer $token", image, bodyParts);

    log(response.toString(), name: "RESINAPI");

    return response;
  }
}
