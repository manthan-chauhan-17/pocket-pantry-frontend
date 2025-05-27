
import 'package:equatable/equatable.dart';

abstract class DropDownEvent extends Equatable {
   @override
  List<Object?> get props => [];
}


class GetDropDownItemsEvent extends DropDownEvent{
  final String? item;

  GetDropDownItemsEvent({this.item});
   
  @override
  List<Object?> get props => [item];

}