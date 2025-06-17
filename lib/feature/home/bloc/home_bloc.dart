import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_event.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_state.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ItemModel itemModel = ItemModel();
  HomeBloc() : super(HomeInitial()) {
    on<GetItemEvent>(getItems);
    on<NavigateToAddItemScreenEvent>(navigateToAddItemScreen);
  }

  FutureOr<void> getItems(GetItemEvent event, Emitter<HomeState> emit) async {
    emit(GetItemsLoadingState());

    try {
      itemModel = await Api.getItems();

      if (itemModel.statusCode == 200) {
        log(itemModel.item.toString(), name: "get items bloc");
        emit(GetItemsSuccessState(items: itemModel.item!));
      } else {
        emit(GetItemsErrorState());
      }
    } catch (e) {
      log(e.toString(), name: "GetItemsError");
      emit(GetItemsErrorState());
    }
  }

  void navigateToAddItemScreen(
      NavigateToAddItemScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToAddItemScreenState());
  }
}
