import 'package:flutter/material.dart';
import '../view/home.dart';

class HomeScreen extends StatefulWidget {

  static String route = "home";

  @override
  HomeScreenController createState() => HomeScreenController();
}

class HomeScreenController extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => HomeScreenView(this);
}

