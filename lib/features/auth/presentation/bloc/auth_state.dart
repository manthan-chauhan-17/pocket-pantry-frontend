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

class LoginUserLoading extends AuthState {}

class LoginUserSuccess extends AuthState {
  final LoginUserEntity loginUserEntity;

  const LoginUserSuccess({required this.loginUserEntity});

  @override
  List<Object> get props => [loginUserEntity];
}

class LoginUserFailure extends AuthState {
  final String message;

  const LoginUserFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class TogglePasswordVisibilityState extends AuthState {
  final bool isVisible;

  const TogglePasswordVisibilityState({required this.isVisible});

  @override
  // TODO: implement props
  List<Object> get props => [isVisible];
}
