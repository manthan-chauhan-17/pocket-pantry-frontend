import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/bloc/auth_bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/bloc/item_bloc/item_bloc.dart';
import 'package:pocket_pantry_frontend/screens/auth_screen/register_screen.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Api.checkHealthApi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ItemBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pantry',
        home: RegisterScreen(),
      ),
    );
  }
}
