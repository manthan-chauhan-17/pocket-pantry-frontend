import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/features/add_item/data/model/add_item_request_model.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/entities/add_item_success_entity.dart';
import 'package:pocket_pantry_frontend/features/add_item/domain/repositories/add_item_repository.dart';

class AddItemUsecase {
  AddItemRepository repository;

  AddItemUsecase(this.repository);

  Future<Either<Failure, AddItemSuccessEntity>> addItem({
    required AddItemRequestModel request,
  }) async {
    return await repository.addItem(request);
  }
}
