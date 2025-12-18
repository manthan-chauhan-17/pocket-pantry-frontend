import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/core/network/api_client.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';
import 'package:pocket_pantry_frontend/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:pocket_pantry_frontend/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:pocket_pantry_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/repository/auth_repository.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/usecases/auth_usecase.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/bloc/auth_bloc.dart';

void setAuthModule(GetIt sl) {
  sl.registerFactory(() => AuthBloc(sl()));

  sl.registerLazySingleton(() => AuthUsecase(sl()));

  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<SafeApiCall>(), sl<AuthRemoteDatasource>()),
  );
}
