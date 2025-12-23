part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginUserEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class TogglePasswordVisibilityEvent extends AuthEvent {
  final bool isVisible;

  const TogglePasswordVisibilityEvent({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}
