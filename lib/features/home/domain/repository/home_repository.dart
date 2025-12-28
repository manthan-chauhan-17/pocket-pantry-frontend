import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/features/home/domain/entities/get_items_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, GetItemsEntity>> getItems({required String token});
}
