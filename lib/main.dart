import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pocket_pantry_frontend/feature/add_item/bloc/add_item_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/home/bloc/home_bloc.dart';
import 'package:pocket_pantry_frontend/feature/item_detail/bloc/item_detail_bloc.dart';
import 'package:pocket_pantry_frontend/feature/splash/bloc/splash_bloc.dart';
import 'package:pocket_pantry_frontend/feature/splash/splash_screen.dart';
import 'package:pocket_pantry_frontend/services/api_service/api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/services/notification_service/firebase_service.dart';
import 'package:pocket_pantry_frontend/services/notification_service/notification_service.dart';
import 'package:pocket_pantry_frontend/services/storage_service/hive/hive_model/hive_item_model.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Api.checkHealthApi();
  // ✅ Initialize Hive
  await Hive.initFlutter();
  // ✅ Register Hive adapter
  Hive.registerAdapter(HiveItemModelAdapter());
  // await Firebase.initializeApp();
  // await NotificationService.initialize();
  // await FirebaseService.firebaseService.getFCMToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => SplashBloc()),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(create: (context) => DropDownBloc()),
        BlocProvider(create: (context) => ImagePickerBloc()),
        BlocProvider(create: (context) => ItemDetailBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pantry',
        themeMode: ThemeMode.system,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme(context),
        home: SplashScreen(),
      ),
    );
  }
}
