

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_egsys/core/io/exception.dart';
import 'package:pokedex_egsys/data/pokemon.dart';
import 'package:pokedex_egsys/vmc/controller/pokemon.dart';
import 'package:pokedex_egsys/widgets/search_pokemon.dart';
import 'package:pokedex_egsys/core/search_provider.dart';
import 'package:pokedex_egsys/vmc/model/home.dart';

import '../view/home.dart';

class HomeScreen extends StatefulWidget {

  static String route = "home";

  @override
  HomeScreenController createState() => HomeScreenController();
}

class HomeScreenController extends State<HomeScreen> {

  HomeModel model;

  bool _searchingForPokemon;
  bool get isSearchingForPokemon => _searchingForPokemon;

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();

    model = HomeModel(provider: context.read<SearchProvider>());
    _scrollController = ScrollController();
    _searchingForPokemon = false;

    _scrollController.addListener(() {
      _handleScrollEvents();
    });

    _fetch(initial: true);
  }

  @override
  dispose() {
    model.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> onRandomButtonPressed() async {
    try {
      _changeSearchingForPokemonStatus(true);
      PokemonData data = await model.getRandomPokemon();
      _changeSearchingForPokemonStatus(false);

      _navigateToPokemonPage(data);
    } 
    on IOException catch(ex) {
      _changeSearchingForPokemonStatus(false);
      _showToast(ex.message);
    }
  }

  Future<void> onSearchPressed() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    showSearch(
      context: context, delegate: SearchPokemonDelegate(
        context.read<SearchProvider>()
      ),
    );
  }

  onPokemonPressed(PokemonData data) {
    _navigateToPokemonPage(data);
  }

  _fetch({bool initial}) async {
    try {
      model.getPokemonsOnRange(initial);
    } 
    on IOException catch (ex) {
      _showToast(ex.message);
    }
  }

  _handleScrollEvents() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetch(initial: false);
    }
  }

  _navigateToPokemonPage(PokemonData data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonScreen(
      data: data
    )));
  }

  _showToast(String message) {
    Toast.show(
      message, 
      context,
      textColor: Colors.white,
      duration: 2,
      backgroundColor: Colors.red,
      gravity: Toast.CENTER
    );
  }

  _changeSearchingForPokemonStatus(bool status) {
    setState(() {
      _searchingForPokemon = status;
    });
  }

  @override
  Widget build(BuildContext context) => HomeScreenView(this);
}

