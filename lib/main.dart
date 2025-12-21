import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pocket_pantry_frontend/core/router/app_routes.dart';
import 'package:pocket_pantry_frontend/core/services/hive_cache_service.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/theme/theme_service.dart';
import 'package:pocket_pantry_frontend/di/injector.dart';

final themeService = ThemeService();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveCacheService.init(); // Ensures Hive is ready before DI
  await initDi();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<AppRouter>().router;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService,
      builder: (context, themeMode, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pantry',
        // themeMode: themeMode,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
      ),
    );
  }
}
