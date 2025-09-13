part of 'item_detail_bloc.dart';

sealed class ItemDetailState extends Equatable {
  const ItemDetailState();

  @override
  List<Object> get props => [];
}

final class ItemDetailInitial extends ItemDetailState {}

class GetItemDetailLoadingState extends ItemDetailState {}

class GetITemDEtailSuccessState extends ItemDetailState {
  final ItemDetailModel itemModel;
  const GetITemDEtailSuccessState({required this.itemModel});

  @override
  List<Object> get props => [itemModel];
}

class GetItemDetailErrorState extends ItemDetailState {
  final String message;
  const GetItemDetailErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
