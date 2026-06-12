import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/core/utils/safe_api_call.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/datasource/add_item_datasource.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_request_model.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/entities/add_item_success_entity.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/repositories/add_item_repository.dart';

class AddItemRepositoryImpl implements AddItemRepository {
  SafeApiCall safeApiCall;
  AddItemDatasource datasource;

  AddItemRepositoryImpl(this.safeApiCall, this.datasource);

  @override
  Future<Either<Failure, AddItemSuccessEntity>> addItem(
    AddItemRequestModel request,
  ) async {
    final result = await safeApiCall.execute(() => datasource.addItem(request));

    return result.map((response) => response.toEntity());
  }
}
