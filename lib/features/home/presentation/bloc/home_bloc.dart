import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/features/home/domain/entities/get_items_entity.dart';
import 'package:pocket_pantry_frontend/features/home/domain/usecases/home_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecases homeUsecases;
  HomeBloc(this.homeUsecases) : super(HomeInitial()) {
    on<GetItemsEvent>(_getItems);
  }

  FutureOr<void> _getItems(GetItemsEvent event, Emitter<HomeState> emit) async {
    emit(GetItemsLoadingState());

    final token = await PreferenceService.getToken();

    final result = await homeUsecases.getItems(token: token);

    result.fold(
      (failure) => emit(GetItemsErrorState(message: failure.message)),
      (response) => emit(GetItemsSuccessState(getItemsEntity: response)),
    );
  }
}
