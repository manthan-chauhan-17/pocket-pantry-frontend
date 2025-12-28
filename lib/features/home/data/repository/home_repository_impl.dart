import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';
import 'package:pocket_pantry_frontend/features/home/data/datasource/home_remote_datasource.dart';
import 'package:pocket_pantry_frontend/features/home/domain/entities/get_items_entity.dart';
import 'package:pocket_pantry_frontend/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  SafeApiCall safeApiCall;
  HomeRemoteDatasource homeRemoteDatasource;
  HomeRepositoryImpl(this.safeApiCall, this.homeRemoteDatasource);

  @override
  Future<Either<Failure, GetItemsEntity>> getItems({
    required String token,
  }) async {
    final result = await safeApiCall.execute(
      () => homeRemoteDatasource.getItems(token: token),
    );

    return result.map((response) => response.toEntity());
  }
}
