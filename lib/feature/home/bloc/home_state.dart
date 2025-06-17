import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/feature/home/models/item_model.dart';

class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class NavigationState extends HomeState {
  final int currentIndex;

  NavigationState({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}

class GetItemsLoadingState extends HomeState {}

class GetItemsSuccessState extends HomeState {
  final List<Item> items;

  GetItemsSuccessState({required this.items});

  @override
  List<Object?> get props => [items];
}

class GetItemsErrorState extends HomeState {}

class NavigateToAddItemScreenState extends HomeState {}
