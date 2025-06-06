part of 'item_detail_bloc.dart';

sealed class ItemDetailState extends Equatable {
  const ItemDetailState();
  
  @override
  List<Object> get props => [];
}

final class ItemDetailInitial extends ItemDetailState {}
