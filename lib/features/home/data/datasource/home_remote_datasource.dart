import 'package:pocket_pantry_frontend/features/home/data/models/get_expiring_soon_items_model.dart';
import 'package:pocket_pantry_frontend/features/home/data/models/get_items_model.dart';

abstract class HomeRemoteDatasource {
  Future<GetItemsModel> getItems({required String token});

  Future<GetExpiringSoonItemsModel> getExpiringSoonItems({
    required String token,
  });
}
