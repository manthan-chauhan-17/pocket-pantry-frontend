import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pocket_pantry_frontend/bloc/auth_bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/bloc/auth_bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/models/user_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserModel userModel = UserModel();

  AuthBloc() : super(AuthInitialState()) {
    on<AuthRegisterEvent>(authRegister);
    on<AuthLoginEvent>(authLogin);
  }

  FutureOr<void> authRegister(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthRegisterLoadingState());
    try {
      userModel =
          await Api.registerUser(event.name, event.email, event.password);

      log(userModel.toString());
      emit(AuthRegisterSuccessState());
    } catch (error) {
      log(error.toString(), name: "ERROR_BLOC");
      emit(
        AuthLoginErrorState(
          error: error.toString(),
        ),
      );
    }
  }

  FutureOr<void> authLogin(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoadingState());

    try {
      userModel = await Api.loginUser(event.email, event.password);
      emit(AuthLoginSuccessState());
    } catch (error) {
      log(error.toString(), name: "ERROR_BLOC");
      emit(
        AuthLoginErrorState(
          error: error.toString(),
        ),
      );
    }
  }
}
