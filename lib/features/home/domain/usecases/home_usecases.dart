import 'package:dartz/dartz.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/features/home/domain/entities/get_items_entity.dart';
import 'package:pocket_pantry_frontend/features/home/domain/repository/home_repository.dart';

class HomeUsecases {
  HomeRepository homeRepository;
  HomeUsecases(this.homeRepository);

  Future<Either<Failure, GetItemsEntity>> getItems({
    required String token,
  }) async {
    return await homeRepository.getItems(token: token);
  }
}
