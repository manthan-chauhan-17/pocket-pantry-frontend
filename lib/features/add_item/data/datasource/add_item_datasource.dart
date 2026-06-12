import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_request_model.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_success_model.dart';

abstract class AddItemDatasource {
  Future<AddItemSuccessModel> addItem(AddItemRequestModel request);
}
