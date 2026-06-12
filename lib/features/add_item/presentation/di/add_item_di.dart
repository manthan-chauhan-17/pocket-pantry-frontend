import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/datasource/add_item_datasource.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/datasource/add_item_datasource_impl.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/repositories/add_item_repository_impl.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/repositories/add_item_repository.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/usecases/add_item_usecase.dart';
import 'package:pocket_pantry_frontend/features/add_item/presentation/bloc/add_item_bloc.dart';

void setAddItemModule(GetIt sl) {
  sl.registerFactory(() => AddItemBloc(addItemUsecase: sl()));

  sl.registerLazySingleton(() => AddItemUsecase(sl()));

  sl.registerLazySingleton<AddItemDatasource>(
    () => AddItemDatasourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<AddItemRepository>(
    () => AddItemRepositoryImpl(sl<SafeApiCall>(), sl<AddItemDatasource>()),
  );
}
