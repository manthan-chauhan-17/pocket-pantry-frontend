import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/features/add_item/presentation/bloc/add_item_bloc.dart';

void setAddItemModule(GetIt sl) {
  sl.registerFactory(() => AddItemBloc());

  // sl.registerLazySingleton(() => HomeUsecases(sl()));

  // sl.registerLazySingleton<HomeRemoteDatasource>(
  //   () => HomeRemoteDatasourceImpl(sl<ApiClient>()),
  // );

  // sl.registerLazySingleton<HomeRepository>(
  //   () => HomeRepositoryImpl(sl<SafeApiCall>(), sl<HomeRemoteDatasource>()),
  // );
}
