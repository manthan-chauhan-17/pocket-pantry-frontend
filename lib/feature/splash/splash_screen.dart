import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/feature/splash/bloc/splash_bloc.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/screen_navigation.dart';
import 'package:pocket_pantry_frontend/typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SplashBloc>().add(StartSplashEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashComplete) {
          // Navigate to the RegisterScreen when the splash is complete
          state.isLoggedIn
              ? ScreenNavigation.push(context, HomeScreen())
              : ScreenNavigation.pushReplacement(context, RegisterScreen());
        }
      },
      child: SafeArea(
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0 * getResponsive(context),
          ),
          child: Container(
            height: getHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.03 * getHeight(context),
                ),
                Text(
                  "PantryPal",
                  style: TextStyle(
                    fontSize: 25 * getResponsiveText(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 0.02 * getHeight(context),
                ),
                Text(
                  "Welcome to PantryPal",
                  style: AppTextTheme.getLightTextTheme(context).displayLarge,
                ),
                SizedBox(
                  height: 0.005 * getHeight(context),
                ),
                Text(
                  "Your smart pantry assistant for managing your food inventory and reducing waste",
                  style: AppTextTheme.getLightTextTheme(context).titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 0.04 * getHeight(context),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20 * getResponsive(context),
                  ),
                  child: Image.asset(
                    'assets/images/splash.png',
                    fit: BoxFit.cover,
                    height: 0.5 * getHeight(context),
                  ),
                ),
                SizedBox(
                  height: 0.03 * getHeight(context),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 0.3 * getHeight(context)),
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20 * getResponsiveText(context),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 0.01 * getHeight(context),
                ),
                SizedBox(
                  height: 0.009 * getHeight(context),
                  child: BlocBuilder<SplashBloc, SplashState>(
                    builder: (context, state) {
                      double progress = 0.0;
                      if (state is SplashProgressState) {
                        progress = state.progress;
                      }
                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: progress),
                        duration: Duration(milliseconds: 900),
                        builder: (context, value, child) {
                          return LinearProgressIndicator(
                            value: value,
                            color: AppColors.lightPrimaryGreen,
                            backgroundColor: AppColors.secondaryLightBackground,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 0.02 * getHeight(context),
                ),
                Text(
                  "version 1.0.0",
                  style: TextStyle(color: AppColors.greenText),
                ),
                SizedBox(
                  height: 0.02 * getHeight(context),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
