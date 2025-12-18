import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/router/route_paths.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/screens/signup_screen.dart';

List<RouteBase> authRoutes = [
  ShellRoute(
    builder: (context, state, child) =>
        BlocProvider(create: (context) => GetIt.I<AuthBloc>(), child: child),
    routes: [
      GoRoute(
        name: RoutePaths.signup,
        path: RoutePaths.signup,
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        name: RoutePaths.login,
        path: RoutePaths.login,
        builder: (context, state) => LoginScreen(),
      ),
    ],
  ),
];
