import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/router/route_paths.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    routes: [],
  );
}
