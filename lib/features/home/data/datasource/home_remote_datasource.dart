import 'package:pocket_pantry_frontend/features/home/data/models/get_items_model.dart';

abstract class HomeRemoteDatasource {
  Future<GetItemsModel> getItems({required String token});
}
