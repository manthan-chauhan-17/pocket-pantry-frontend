import 'dart:convert';

import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/datasource/add_item_datasource.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_request_model.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_success_model.dart';

class AddItemDatasourceImpl implements AddItemDatasource {
  ApiClient apiClient;

  AddItemDatasourceImpl(this.apiClient);

  @override
  Future<AddItemSuccessModel> addItem(AddItemRequestModel request) async {
    final response = await apiClient.postGenericMultipart(
      'item/add-item',
      request.toFormData(),
    );

    return AddItemSuccessModel.fromJson(jsonDecode(response));
  }
}
