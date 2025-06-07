part of 'item_detail_bloc.dart';

class ItemDetailEvent extends Equatable {
  const ItemDetailEvent();

  @override
  List<Object> get props => [];
}

class DeleteItemEvent extends ItemDetailEvent {
  final String id;

  const DeleteItemEvent({required this.id});

  @override
  List<Object> get props => [id];
}
