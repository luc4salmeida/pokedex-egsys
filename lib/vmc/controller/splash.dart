import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/search_provider.dart';
import 'package:pokedex_egsys/vmc/model/splash.dart';

import '../view/splash.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  static String route = "splash";

  @override
  SplashScreenController createState() => SplashScreenController();
}

class SplashScreenController extends State<SplashScreen> {

  SplashModel model;

  @override
  void initState() {
    super.initState();
    model = SplashModel(context.read<SearchProvider>());
    _init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _init() async {
    //Mock delay
    await Future.delayed(Duration(seconds: 3));

    await model.loadSuggestions();

    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) => SplashScreenView(this);
}