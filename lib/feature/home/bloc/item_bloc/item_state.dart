import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';

class ItemState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ItemInitialState extends ItemState {}

class GetItemsLoadingState extends ItemState {}

class GetItemsSuccessState extends ItemState {
  final List<Data> items;

  GetItemsSuccessState({required this.items});

  @override
  List<Object?> get props => [items];
}

class GetItemsErrorState extends ItemState {}
