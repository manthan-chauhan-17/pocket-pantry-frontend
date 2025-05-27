import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

// This state is used when the user is not authenticated
class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {}

class AuthRegisterErrorState extends AuthState {
  final String error;

  AuthRegisterErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

// This state is used when the user is trying to log in
class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthLoginErrorState extends AuthState {
  final String error;

  AuthLoginErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
