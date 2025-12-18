import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/router/route_paths.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startSplashTimer();
  }

  void _startSplashTimer() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check if the widget is still mounted before using context
    if (mounted) {
      navigateToNextScreen();
    }
  }

  void navigateToNextScreen() {
    context.pushNamed(RoutePaths.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.kitchen,
              color: AppTheme.getColor(context).primary,
              size: 130,
            ),
            CustomText('Pocket Pantry', fontSize: 20.0),
            SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
            CircularProgressIndicator(
              color: AppTheme.getColor(context).primary,
            ),
            // SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
            // CustomText('v 1.0.0'),
          ],
        ),
      ),
    );
  }
}
