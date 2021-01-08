import 'package:flutter/material.dart';
import '../view/splash.dart';

class SplashScreen extends StatefulWidget {

  static String route = "splash";

  @override
  SplashScreenController createState() => SplashScreenController();
}

class SplashScreenController extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _startMockDelay();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _startMockDelay() async {
    await Future.delayed(
      Duration(seconds: 3)
    );

    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) => SplashScreenView(this);
}