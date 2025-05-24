import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/screens/home_screen.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';

void main() {
  Api.checkHealthApi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Pantry',
      home: HomeScreen(),
    );
  }
}
