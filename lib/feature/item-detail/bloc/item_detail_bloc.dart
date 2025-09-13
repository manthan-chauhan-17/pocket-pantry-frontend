import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/feature/item-detail/model/item_detail_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc() : super(ItemDetailInitial()) {
    on<GetItemDetailEvent>(getItemDetail);
  }

  FutureOr<void> getItemDetail(
      GetItemDetailEvent event, Emitter<ItemDetailState> emit) async {
    emit(GetItemDetailLoadingState());

    try {
      ItemDetailModel result = await Api.getSingleItem(itemId: event.itemId);

      if (result.statusCode == 200) {
        emit(GetITemDEtailSuccessState(itemModel: result));
      } else {
        emit(GetItemDetailErrorState(
            message: result.message ?? "Something Went Wrong"));
      }
    } catch (e) {
      emit(GetItemDetailErrorState(message: e.toString()));
    }
  }
}
