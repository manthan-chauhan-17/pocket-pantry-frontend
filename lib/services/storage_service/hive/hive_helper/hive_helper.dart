import 'package:hive/hive.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_model/hive_item_model.dart';

class HiveItemHelper {
  static const String _boxName = 'itemBox';

  /// Open the itemBox
  static Future<Box<HiveItemModel>> _openBox() async {
    return await Hive.openBox<HiveItemModel>(_boxName);
  }

  /// Add an item
  static Future<void> addItem(HiveItemModel item) async {
    final box = await _openBox();
    await box.add(item);
  }

  /// Get all items
  static Future<List<HiveItemModel>> getAllItems() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// Get item by index/key
  static Future<HiveItemModel?> getItem(int index) async {
    final box = await _openBox();
    return box.getAt(index);
  }

  /// Update item by index/key
  static Future<void> updateItem(int index, HiveItemModel updatedItem) async {
    final box = await _openBox();
    await box.putAt(index, updatedItem);
  }

  /// Delete item by index/key
  static Future<void> deleteItem(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  /// Clear all items
  static Future<void> clearItems() async {
    final box = await _openBox();
    await box.clear();
  }

  /// Replace all items (e.g., after sync with API)
  static Future<void> replaceAll(List<HiveItemModel> items) async {
    final box = await _openBox();
    await box.clear();
    await box.addAll(items);
  }

  /// Close the box
  static Future<void> closeBox() async {
    final box = await _openBox();
    await box.close();
  }
}
