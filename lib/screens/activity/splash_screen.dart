import 'package:astrotak/app/app_state.dart';
import 'package:astrotak/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends AppState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Image.asset(
          "assets/icons/logo.png",
          height: 200,
          width: 200,
        ),
      )),
    );
  }

  @override
  void initState() {
    if (mounted) {
      navigateScreen();
    }
    super.initState();
  }

  void navigateScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.dashboardScreen, (route) => false);
    });
  }
}
