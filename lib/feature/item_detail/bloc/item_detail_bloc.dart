import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc() : super(ItemDetailInitial()) {
    on<ItemDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
