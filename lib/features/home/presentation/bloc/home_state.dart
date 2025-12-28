part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class GetItemsLoadingState extends HomeState {}

class GetItemsSuccessState extends HomeState {
  final GetItemsEntity getItemsEntity;

  const GetItemsSuccessState({required this.getItemsEntity});
}

class GetItemsErrorState extends HomeState {
  final String message;

  const GetItemsErrorState({required this.message});
}
