import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/entities/register_user_entity.dart';
import 'package:pocket_pantry_frontend/features/auth/domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc(this.authUsecase) : super(AuthInitial()) {
    on<RegisterUserEvent>(_registerUser);
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
        PreferenceService.setIsLoggedIn(registerUserEntity.success ?? false);
        emit(RegisterUserSuccess(registerUserEntity: registerUserEntity));
      },
    );
  }
}
