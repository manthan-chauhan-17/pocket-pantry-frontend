import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/router/route_paths.dart';
import 'package:pocket_pantry_frontend/features/add_item/presentation/screens/add_item_screen.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/features/home/presentation/screens/home_screen.dart';

List<RouteBase> homeRoutes = [
  ShellRoute(
    builder: (context, state, child) =>
        BlocProvider(create: (context) => GetIt.I<HomeBloc>(), child: child),
    routes: [
      GoRoute(
        name: RoutePaths.home,
        path: RoutePaths.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: RoutePaths.addItem,
        path: RoutePaths.addItem,
        builder: (context, state) => AddItemScreen(),
      ),
    ],
  ),
];
