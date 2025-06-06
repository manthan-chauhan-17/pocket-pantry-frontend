import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BottomNavBarTappedEvent extends HomeEvent {
  final int index;

  BottomNavBarTappedEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class GetItemEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class NavigateToAddItemScreenEvent extends HomeEvent {}
