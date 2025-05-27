import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>(_onStartSplash);
  }

  Future<void> _onStartSplash(
      StartSplashEvent event, Emitter<SplashState> emit) async {
    emit(SplashProgressState(progress: 0.0));

    for (int i = 1; i <= 4; i++) {
      await Future.delayed(const Duration(seconds: 1));
      double progress = i * 0.25;
      emit(SplashProgressState(progress: progress));
    }

    emit(SplashComplete());
  }
}
