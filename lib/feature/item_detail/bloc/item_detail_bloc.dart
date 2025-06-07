import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc() : super(ItemDetailInitial()) {
    on<DeleteItemEvent>(deleteItem);
  }

  FutureOr<void> deleteItem(
      DeleteItemEvent event, Emitter<ItemDetailState> emit) {
    emit(DeleteItemLoadingState());

    try {
      var res = Api.deleteItemFromList(id: event.id);

      log(res.toString(), name: "res in bloc");
      emit(DeleteItemSuccessState());
    } catch (e) {
      log(e.toString(), name: "error bloc");
      emit(DeleteItemErrorState());
    }
  }
}
