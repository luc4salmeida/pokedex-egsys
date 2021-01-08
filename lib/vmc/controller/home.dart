import 'package:flutter/material.dart';
import '../view/home.dart';


import '../model/home.dart';

class HomeScreen extends StatefulWidget {

  static String route = "home";

  @override
  HomeScreenController createState() => HomeScreenController();
}

class HomeScreenController extends State<HomeScreen> {

  HomeModel model;

  @override
  void initState() {
    super.initState();
    model = HomeModel();

    _init();
  }

  _init() async {
    await model.getRandomPokemon();
  }

  @override
  Widget build(BuildContext context) => HomeScreenView(this);
}

