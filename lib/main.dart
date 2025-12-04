import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/theme/theme_service.dart';

final themeService = ThemeService();
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pocket Pantry',
          themeMode: themeMode,
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          home: const Scaffold(
            body: Center(child: Text('Pocket Pantry - scaffold ready')),
          ),
        );
      },
    );
  }
}
