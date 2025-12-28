import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';
import 'package:pocket_pantry_frontend/features/home/data/datasource/home_remote_datasource.dart';
import 'package:pocket_pantry_frontend/features/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:pocket_pantry_frontend/features/home/data/repository/home_repository_impl.dart';
import 'package:pocket_pantry_frontend/features/home/domain/repository/home_repository.dart';
import 'package:pocket_pantry_frontend/features/home/domain/usecases/home_usecases.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/bloc/home_bloc.dart';

void setHomeModule(GetIt sl) {
  sl.registerFactory(() => HomeBloc(sl()));

  sl.registerLazySingleton(() => HomeUsecases(sl()));

  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<SafeApiCall>(), sl<HomeRemoteDatasource>()),
  );
}
