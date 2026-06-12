part of 'add_item_bloc.dart';

sealed class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends AddItemEvent {
  final ImageSource source;

  const PickImageEvent(this.source);

  @override
  List<Object?> get props => [source];
}

class RemoveImageEvent extends AddItemEvent {
  const RemoveImageEvent();
}

class AddItemDetailsEvent extends AddItemEvent {
  final AddItemRequestModel request;

  const AddItemDetailsEvent({required this.request});

  @override
  List<Object?> get props => [request];
}
