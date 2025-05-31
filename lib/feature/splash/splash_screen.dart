import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/splash/bloc/splash_bloc.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // final Duration duration = const Duration(seconds: 10);
  // late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    context.read<SplashBloc>().add(StartSplashEvent());

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: duration,
    // )..forward().whenComplete(() {
    //     ScreenNavigation.pushReplacement(context, RegisterScreen());
    //   });
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashComplete) {
          // Navigate to the RegisterScreen when the splash is complete
          ScreenNavigation.pushReplacement(context, RegisterScreen());
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25.0 * getResponsive(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "PantryPal",
                  style: TextStyle(
                    fontSize: 25 * getResponsiveText(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 0.015 * getHeight(context),
                ),
                Text(
                  "Welcome to PantryPal",
                  style: AppTextTheme.getLightTextTheme(context).displayLarge,
                ),
                Text(
                  "Your smart pantry assistant for managing your food inventory and reducing waste",
                  style: AppTextTheme.getLightTextTheme(context).titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 0.035 * getHeight(context),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20 * getResponsive(context),
                  ),
                  child: Image.asset(
                    'assets/images/splash_image.png',
                    fit: BoxFit.cover,
                    width: 0.9 * getWidth(context),
                    height: 0.55 * getHeight(context),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 0.3 * getHeight(context)),
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20 * getResponsiveText(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
