import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

abstract class DropDownState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DropDownInitialState extends DropDownState {
  final String? selectedItem;

  DropDownInitialState({this.selectedItem});

  @override
  List<Object?> get props => [selectedItem];
}
