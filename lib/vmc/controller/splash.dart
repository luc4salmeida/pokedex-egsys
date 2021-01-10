import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/search_provider.dart';

import '../view/splash.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart' show rootBundle;

class SplashScreen extends StatefulWidget {

  static String route = "splash";

  @override
  SplashScreenController createState() => SplashScreenController();
}

class SplashScreenController extends State<SplashScreen> {

  SearchProvider _searchProvider;

  @override
  void initState() {
    super.initState();

    _searchProvider = context.read<SearchProvider>();
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

    String pokemonList = await rootBundle.loadString("assets/pokemon_list.txt");
    List<String> pokemonsName = pokemonList.split('\n');

    String typesList = await rootBundle.loadString("assets/types_list.txt");
    List<String> typesName = typesList.split('\n');
    
    _searchProvider.addSuggestionsToList(pokemonsName);
    _searchProvider.addSuggestionsToList(typesName);

    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) => SplashScreenView(this);
}