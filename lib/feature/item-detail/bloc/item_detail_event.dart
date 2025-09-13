part of 'item_detail_bloc.dart';

sealed class ItemDetailEvent extends Equatable {
  const ItemDetailEvent();

  @override
  List<Object> get props => [];
}

class GetItemDetailEvent extends ItemDetailEvent {
  final String itemId;

  const GetItemDetailEvent({required this.itemId});

  @override
  List<Object> get props => [itemId];
}
