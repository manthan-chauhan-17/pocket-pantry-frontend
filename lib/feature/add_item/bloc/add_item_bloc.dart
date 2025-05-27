import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_event.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_state.dart';


class DropDownBloc extends Bloc<DropDownEvent, DropDownState> {
  DropDownBloc() : super(DropDownInitialState()) {
    on<GetDropDownItemsEvent>(selectedItem);
  }
  selectedItem(GetDropDownItemsEvent event, Emitter<DropDownState> emit) {
    emit(DropDownInitialState(selectedItem: event.item));
  }
}
