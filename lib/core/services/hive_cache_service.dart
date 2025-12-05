import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_pantry_frontend/core/services/cache_service.dart';

/// A caching service implementation that uses Hive for local storage.
class HiveCacheService implements CacheService {
  /// Initializes Hive for the application and registers all necessary adapters.
  /// This should be called once in main.dart before runApp().
  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  /// Centralized function to register all Hive TypeAdapters.
  static void _registerAdapters() {
    // Check if adapters are already registered to avoid errors during hot reloads.
    // if (!Hive.isAdapterRegistered(HomeMenuResponseAdapter().typeId)) {
    //   Hive.registerAdapter(HomeMenuResponseAdapter());
    // }
  }

  /// Opens a Hive box. If the box is already open, it returns the existing instance.
  Future<Box> _openBox(String boxName) async => await Hive.openBox(boxName);

  @override
  Future<T?> get<T>(String boxName, String key) async {
    final box = await _openBox(boxName);
    return box.get(key) as T?;
  }

  @override
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<void> delete(String boxName, String key) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }
}
