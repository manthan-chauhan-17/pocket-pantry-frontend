import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/features/home/domain/entities/get_expiring_soon_items_entity.dart';
import 'package:pocket_pantry_frontend/features/home/domain/entities/get_items_entity.dart';
import 'package:pocket_pantry_frontend/features/home/domain/usecases/home_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, GetItemsState> {
  final HomeUsecases homeUsecases;
  HomeBloc(this.homeUsecases) : super(GetItemInititalState()) {
    on<GetAllItemsEvent>(_getItems);
    on<GetExpiringSoonItemsEvent>(_getExpiringSoonItems);
  }

  FutureOr<void> _getItems(
    GetAllItemsEvent event,
    Emitter<GetItemsState> emit,
  ) async {
    final token = await PreferenceService.getToken();
    emit(state.copyWith(allItemsLoading: true, allItemsErrorMessage: ''));

    final result = await homeUsecases.getItems(token: token);

    result.fold(
      (failure) => emit(
        state.copyWith(
          allItemsErrorMessage: failure.message,
          allItemsLoading: false,
        ),
      ),
      (response) => emit(
        state.copyWith(allItemsLoading: false, getItemsEntity: response),
      ),
    );
  }

  FutureOr<void> _getExpiringSoonItems(
    GetExpiringSoonItemsEvent event,
    Emitter<GetItemsState> emit,
  ) async {
    final token = await PreferenceService.getToken();
    emit(
      state.copyWith(expiringSoonLoading: true, expiringSoonErrorMessage: ''),
    );

    final result = await homeUsecases.getExpiringSoonItems(token: token);

    result.fold(
      (failure) => emit(
        state.copyWith(
          expiringSoonErrorMessage: failure.message,
          expiringSoonLoading: false,
        ),
      ),
      (response) => emit(
        state.copyWith(
          expiringSoonLoading: false,
          getExpiringSoonItemsEntity: response,
        ),
      ),
    );
  }
}
