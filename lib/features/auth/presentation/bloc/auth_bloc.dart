import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/login_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/register_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  bool isPasswordVisible = false; // Default to hidden (password is obscured)

  AuthBloc(this.authUsecase) : super(AuthInitial()) {
    on<RegisterUserEvent>(_registerUser);
    on<LoginUserEvent>(_loginUser);
    on<TogglePasswordVisibilityEvent>(_togglePasswordVisibility);
  }

  FutureOr<void> _registerUser(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterUserLoading());

    final result = await authUsecase.registerUser(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(RegisterUserFailure(message: failure.message)),
      (registerUserEntity) {
        emit(RegisterUserSuccess(registerUserEntity: registerUserEntity));
      },
    );
  }

  FutureOr<void> _loginUser(
    LoginUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginUserLoading());

    final result = await authUsecase.loginUser(
      email: event.email,
      password: event.password,
    );

    await result.fold(
      (failure) async => emit(LoginUserFailure(message: failure.message)),
      (response) async {
        await PreferenceService.setIsLoggedIn(response.success ?? false);
        if (response.user != null) {
          await PreferenceService.saveLoginDetails(
            response.user?.token ?? '',
            response.user?.id ?? '',
            response.user?.name ?? '',
            response.user?.email ?? '',
          );
        }

        emit(LoginUserSuccess(loginUserEntity: response));
      },
    );
  }

  FutureOr<void> _togglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    isPasswordVisible = !isPasswordVisible; // Toggle the visibility
    emit(TogglePasswordVisibilityState(isVisible: isPasswordVisible));
  }
}
