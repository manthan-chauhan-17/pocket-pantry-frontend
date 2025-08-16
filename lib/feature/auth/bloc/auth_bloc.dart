import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/feature/auth/models/user_model.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';

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

      log("User registered successfully", name: "AUTH_BLOC");
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

      log(userModel.user!.name.toString(), name: "NAME");

      if (userModel.statusCode == 200) {
        await MySharedPreference.saveUserData(
            id: userModel.user!.id!,
            name: userModel.user!.name!,
            email: userModel.user!.email!,
            token: userModel.user!.token!,
            isLoggedIn: "true");
      }
      log("User logged in successfully", name: "AUTH_BLOC");
      // to register FCM token
      await Api.registerToken();
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
