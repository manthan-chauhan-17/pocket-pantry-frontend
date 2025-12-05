import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/core/router/app_routes.dart';
import 'package:pocket_pantry_frontend/core/services/cache_service.dart';
import 'package:pocket_pantry_frontend/core/services/hive_cache_service.dart';
import 'package:pocket_pantry_frontend/di/init_network_di.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDi() async {
  sl.registerSingleton<AppRouter>(AppRouter());

  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register our Hive-based CacheService as a singleton
  sl.registerSingleton<CacheService>(HiveCacheService());

  // sl.registerLazySingleton<FirebaseMessagingService>(
  //   FirebaseMessagingService.new,
  // ); // Added registration

  // sl.registerSingleton<PreferenceManager>(PreferenceManager());

  await initNetworkDi(sl);
}
