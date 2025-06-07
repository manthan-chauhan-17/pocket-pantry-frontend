part of 'item_detail_bloc.dart';

class ItemDetailState extends Equatable {
  const ItemDetailState();

  @override
  List<Object> get props => [];
}

class ItemDetailInitial extends ItemDetailState {}

class DeleteItemLoadingState extends ItemDetailState {}

class DeleteItemSuccessState extends ItemDetailState {}

class DeleteItemErrorState extends ItemDetailState {}
