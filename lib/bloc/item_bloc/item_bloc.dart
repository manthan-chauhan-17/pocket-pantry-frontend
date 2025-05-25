import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pocket_pantry_frontend/bloc/item_bloc/item_event.dart';
import 'package:pocket_pantry_frontend/bloc/item_bloc/item_state.dart';
import 'package:pocket_pantry_frontend/models/item_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemModel itemModel = ItemModel();
  ItemBloc() : super(ItemState()) {
    on<GetItemEvent>(getItems);
  }

  FutureOr<void> getItems(GetItemEvent event, Emitter<ItemState> emit) async {
    emit(GetItemsLoadingState());

    try {
      itemModel = await Api.getItems();
      if (itemModel.statusCode == 200) {
        log(itemModel.data.toString(), name: "get items bloc");
        emit(GetItemsSuccessState(items: itemModel.data!));
      } else {
        emit(GetItemsErrorState());
      }
    } catch (e) {
      log(e.toString(), name: "GetItemsError");
      emit(GetItemsErrorState());
    }
  }
}
