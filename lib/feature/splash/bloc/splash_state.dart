part of 'splash_bloc.dart';

class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashProgressState extends SplashState {
  final double progress;

  SplashProgressState({required this.progress});

  @override
  List<Object> get props => [progress];
}

class SplashComplete extends SplashState {}
