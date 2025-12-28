import 'dart:convert';

import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/features/home/data/datasource/home_remote_datasource.dart';
import 'package:pocket_pantry_frontend/features/home/data/models/get_items_model.dart';

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  ApiClient apiClient;

  HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<GetItemsModel> getItems({required String token}) async {
    // Token is now automatically added via Dio interceptor
    final response = await apiClient.getDynamic('item/get-items', {});

    return GetItemsModel.fromJson(jsonDecode(response));
  }
}
