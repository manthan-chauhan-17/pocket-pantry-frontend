part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class RegisterUserLoading extends AuthState {}

class RegisterUserSuccess extends AuthState {
  final RegisterUserEntity registerUserEntity;

  const RegisterUserSuccess({required this.registerUserEntity});

  @override
  List<Object> get props => [registerUserEntity];
}

class RegisterUserFailure extends AuthState {
  final String message;

  const RegisterUserFailure({required this.message});

  @override
  List<Object> get props => [message];
}
