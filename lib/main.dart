import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_bloc.dart';

import 'package:pocket_pantry_frontend/feature/add_item/view/add_item.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/login_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/item_bloc/item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/feature/splash/bloc/splash_bloc.dart';
import 'package:pocket_pantry_frontend/feature/splash/splash_screen.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Api.checkHealthApi();
  Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => SplashBloc()),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ItemBloc(),
        ),
        BlocProvider(create: (context) => DropDownBloc()),
        BlocProvider(create: (context) => ImagePickerBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pantry',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),

        home: HomeScreen(),

      ),
    );
  }
}
