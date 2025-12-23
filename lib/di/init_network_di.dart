import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/core/network/dio_provider.dart';
import 'package:pocket_pantry_frontend/core/network/network_info.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';

Future<void> initNetworkDi(GetIt sl) async {
  sl.registerLazySingleton(() => SafeApiCall(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  sl.registerSingleton<Dio>(getDio());
  sl.registerSingleton<ApiClient>(ApiClient(dio, baseUrl: Constant.apiBaseUrl));
}
